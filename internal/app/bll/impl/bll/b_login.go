package bll

import (
	"context"
	"github.com/sirupsen/logrus"
	"net/http"
	"sort"

	"github.com/LyricTian/captcha"
	"github.com/LyricTian/gin-admin/internal/app/bll"
	"github.com/LyricTian/gin-admin/internal/app/model"
	"github.com/LyricTian/gin-admin/internal/app/schema"
	"github.com/LyricTian/gin-admin/pkg/auth"
	"github.com/LyricTian/gin-admin/pkg/errors"
	"github.com/LyricTian/gin-admin/pkg/util"
	"github.com/google/wire"
)

var _ bll.ILogin = (*Login)(nil)

// LoginSet 注入Login
var LoginSet = wire.NewSet(wire.Struct(new(Login), "*"), wire.Bind(new(bll.ILogin), new(*Login)))

// Login 登录管理
type Login struct {
	Auth            auth.Auther
	UserModel       model.IUser
	UserRoleModel   model.IUserRole
	RoleModel       model.IRole
	RoleMenuModel   model.IRoleMenu
	MenuModel       model.IMenu
	MenuActionModel model.IMenuAction
}

// GetCaptcha 获取图形验证码信息
func (a *Login) GetCaptcha(ctx context.Context, length int) (*schema.LoginCaptcha, error) {
	captchaID := captcha.NewLen(length)
	item := &schema.LoginCaptcha{
		CaptchaID: captchaID,
	}
	return item, nil
}

// ResCaptcha 生成并响应图形验证码
func (a *Login) ResCaptcha(ctx context.Context, w http.ResponseWriter, captchaID string, width, height int) error {
	err := captcha.WriteImage(w, captchaID, width, height)
	if err != nil {
		if err == captcha.ErrNotFound {
			return errors.ErrNotFound
		}
		return errors.WithStack(err)
	}

	w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	w.Header().Set("Pragma", "no-cache")
	w.Header().Set("Expires", "0")
	w.Header().Set("Content-Type", "image/png")
	return nil
}

// Verify 登录验证
func (a *Login) Verify(ctx context.Context, userName, password string) (*schema.User, error) {
	// 检查是否是超级用户
	root := GetRootUser()
	if userName == root.UserName && root.Password == password {
		return root, nil
	}

	result, err := a.UserModel.Query(ctx, schema.UserQueryParam{
		UserName: userName,
	})
	if err != nil {
		return nil, err
	} else if len(result.Data) == 0 {
		return nil, errors.ErrInvalidUserName
	}

	item := result.Data[0]
	if item.Password != util.SHA1HashString(password) {
		return nil, errors.ErrInvalidPassword
	} else if item.Status != 1 {
		return nil, errors.ErrUserDisable
	}

	return item, nil
}

// GenerateToken 生成令牌
func (a *Login) GenerateToken(ctx context.Context, userID string) (*schema.LoginTokenInfo, error) {
	tokenInfo, err := a.Auth.GenerateToken(ctx, userID)
	if err != nil {
		return nil, errors.WithStack(err)
	}

	item := &schema.LoginTokenInfo{
		AccessToken: tokenInfo.GetAccessToken(),
		TokenType:   tokenInfo.GetTokenType(),
		ExpiresAt:   tokenInfo.GetExpiresAt(),
	}
	return item, nil
}

// DestroyToken 销毁令牌
func (a *Login) DestroyToken(ctx context.Context, tokenString string) error {
	err := a.Auth.DestroyToken(ctx, tokenString)
	if err != nil {
		return errors.WithStack(err)
	}
	return nil
}

func (a *Login) checkAndGetUser(ctx context.Context, userID string) (*schema.User, error) {
	user, err := a.UserModel.Get(ctx, userID)
	if err != nil {
		return nil, err
	} else if user == nil {
		return nil, errors.ErrInvalidUser
	} else if user.Status != 1 {
		return nil, errors.ErrUserDisable
	}
	return user, nil
}

// GetLoginInfo 获取当前用户登录信息
func (a *Login) GetLoginInfo(ctx context.Context, userID string) (*schema.UserLoginInfo, error) {
	if isRoot := CheckIsRootUser(ctx, userID); isRoot {
		root := GetRootUser()
		loginInfo := &schema.UserLoginInfo{
			UserName: root.UserName,
			RealName: root.RealName,
		}
		return loginInfo, nil
	}

	user, err := a.checkAndGetUser(ctx, userID)
	if err != nil {
		return nil, err
	}

	info := &schema.UserLoginInfo{
		UserID:   user.RecordID,
		UserName: user.UserName,
		RealName: user.RealName,
	}

	userRoleResult, err := a.UserRoleModel.Query(ctx, schema.UserRoleQueryParam{
		UserID: userID,
	})
	if err != nil {
		return nil, err
	}

	if roleIDs := userRoleResult.Data.ToRoleIDs(); len(roleIDs) > 0 {
		roleResult, err := a.RoleModel.Query(ctx, schema.RoleQueryParam{
			RecordIDs: roleIDs,
			Status:    1,
		})
		if err != nil {
			return nil, err
		}
		info.Roles = roleResult.Data
	}

	return info, nil
}

// 查询当前用户的权限菜单树
func (a *Login) QueryUserMenuTree(ctx context.Context, userID string) (schema.MenuTrees, error) {
	logrus.Infof("userId=%s", userID)

	isRoot := CheckIsRootUser(ctx, userID)

	// 如果是root用户，则查询所有显示的菜单树
	if isRoot {
		result, err := a.MenuModel.Query(ctx, schema.MenuQueryParam{
			Status: 1,
		}, schema.MenuQueryOptions{
			OrderFields: schema.NewOrderFields(schema.NewOrderField("sequence", schema.OrderByDESC)),
		})
		if err != nil {
			return nil, err
		}

		// 6个菜单
		logrus.Infof("isRoot menu result=%+v", result)
		for sK, menu := range result.Data {
			logrus.Infof("isRoot sK=%+v menu=%+v", sK, *menu)
		}

		menuActionResult, err := a.MenuActionModel.Query(ctx, schema.MenuActionQueryParam{})
		if err != nil {
			return nil, err
		}

		// 24个菜单操作
		logrus.Infof("isRoot menuActionResult result=%+v", menuActionResult)
		for sK, menuAction := range menuActionResult.Data {
			logrus.Infof("isRoot sK=%+v", sK)
			logrus.Infof("isRoot menuAction=%+v", *menuAction)
			for subSK, resource := range menuAction.Resources {
				logrus.Infof("isRoot subSK=%+v resource=%+v", subSK, resource)
			}
		}

		menuTrees := result.Data.FillMenuAction(menuActionResult.Data.ToMenuIDMap()).ToTree()
		logrus.Infof("isRoot menuTrees=%+v", menuTrees)
		for sK, menuTree := range menuTrees {
			logrus.Infof("isRoot sK=%+v", sK)
			logrus.Infof("isRoot menuTree=%+v", *menuTree)
			// menuTree.Actions = MenuActions = []*MenuAction
			for menuActionIndex, menuAction := range menuTree.Actions {
				logrus.Infof("isRoot menuActionIndex=%+v", menuActionIndex)
				logrus.Infof("isRoot menuAction=%+v", *menuAction)
			}
			// 子级树 menuTree.Children = *MenuTrees = *[]*MenuTree
			logrus.Infof("isRoot menuTree.Children=%+v", menuTree.Children)
			if menuTree.Children != nil {
				for childIndex, childMenuTree := range *menuTree.Children {
					logrus.Infof("isRoot childIndex=%+v", childIndex)
					logrus.Infof("isRoot childMenuTree=%+v", *childMenuTree)
					// childMenuTree.Actions = MenuActions = []*MenuAction
					for childMenuActionIndex, childMenuAction := range childMenuTree.Actions {
						logrus.Infof("isRoot childMenuActionIndex=%+v", childMenuActionIndex)
						logrus.Infof("isRoot childMenuAction=%+v", *childMenuAction)
					}
				}
			}
		}

		return menuTrees, nil
	}

	// 普通管理员用户
	userRoleResult, err := a.UserRoleModel.Query(ctx, schema.UserRoleQueryParam{
		UserID: userID,
	})
	if err != nil {
		return nil, err
	} else if len(userRoleResult.Data) == 0 {
		return nil, errors.ErrNoPerm
	}
	logrus.Infof("userRoleResult=%+v", userRoleResult)
	for sK, userRole := range userRoleResult.Data {
		logrus.Infof("sK=%+v userRole=%+v", sK, *userRole)
	}

	roleMenuResult, err := a.RoleMenuModel.Query(ctx, schema.RoleMenuQueryParam{
		RoleIDs: userRoleResult.Data.ToRoleIDs(),
	})
	if err != nil {
		return nil, err
	} else if len(roleMenuResult.Data) == 0 {
		return nil, errors.ErrNoPerm
	}
	logrus.Infof("roleMenuResult=%+v", roleMenuResult)
	for sK, roleMenu := range roleMenuResult.Data {
		logrus.Infof("sK=%+v roleMenu=%+v", sK, *roleMenu)
	}

	menuResult, err := a.MenuModel.Query(ctx, schema.MenuQueryParam{
		RecordIDs: roleMenuResult.Data.ToMenuIDs(),
		Status:    1,
	})
	if err != nil {
		return nil, err
	} else if len(menuResult.Data) == 0 {
		return nil, errors.ErrNoPerm
	}
	logrus.Infof("menuResult=%+v", menuResult)
	for sK, menu := range menuResult.Data {
		logrus.Infof("sK=%+v menu=%+v", sK, *menu)
	}

	mData := menuResult.Data.ToMap()
	logrus.Infof("mData1=%+v", mData)
	for mK, mV := range mData {
		logrus.Infof("mK=%+v mV=%+v", mK, mV)
	}

	// TODO zyx 没看懂
	var qRecordIDs []string
	for _, pid := range menuResult.Data.SplitParentRecordIDs() {
		if _, ok := mData[pid]; !ok {
			qRecordIDs = append(qRecordIDs, pid)
		}
	}

	if len(qRecordIDs) > 0 {
		pmenuResult, err := a.MenuModel.Query(ctx, schema.MenuQueryParam{
			RecordIDs: menuResult.Data.SplitParentRecordIDs(),
		})
		if err != nil {
			return nil, err
		}
		menuResult.Data = append(menuResult.Data, pmenuResult.Data...)
	}

	sort.Sort(menuResult.Data)

	logrus.Infof("mData2=%+v", mData)
	for mK, mV := range mData {
		logrus.Infof("mK=%+v mV=%+v", mK, mV)
	}

	menuActionResult, err := a.MenuActionModel.Query(ctx, schema.MenuActionQueryParam{
		RecordIDs: roleMenuResult.Data.ToActionIDs(),
	})
	if err != nil {
		return nil, err
	}

	menuTrees := menuResult.Data.FillMenuAction(menuActionResult.Data.ToMenuIDMap()).ToTree()

	logrus.Infof("menuTrees=%+v", menuTrees)
	for sK, menuTree := range menuTrees {
		logrus.Infof("sK=%+v menuTree=%+v", sK, *menuTree)
		// menuTree.Actions = MenuActions = []*MenuAction
		for menuActionIndex, menuAction := range menuTree.Actions {
			logrus.Infof("menuActionIndex=%+v menuAction=%+v", menuActionIndex, *menuAction)
		}
		// 子级树 menuTree.Children = *MenuTrees = *[]*MenuTree
		logrus.Infof("menuTree.Children=%+v", menuTree.Children)
		if menuTree.Children != nil {
			for childIndex, childMenuTree := range *menuTree.Children {
				logrus.Infof("childIndex=%+v childMenuTree=%+v", childIndex, *childMenuTree)
				// childMenuTree.Actions = MenuActions = []*MenuAction
				for childMenuActionIndex, childMenuAction := range childMenuTree.Actions {
					logrus.Infof("childMenuActionIndex=%+v childMenuAction=%+v", childMenuActionIndex, *childMenuAction)
				}
			}
		}
	}

	return menuTrees, nil
}

// UpdatePassword 更新当前用户登录密码
func (a *Login) UpdatePassword(ctx context.Context, userID string, params schema.UpdatePasswordParam) error {
	if CheckIsRootUser(ctx, userID) {
		return errors.New400Response("root用户不允许更新密码")
	}

	user, err := a.checkAndGetUser(ctx, userID)
	if err != nil {
		return err
	} else if util.SHA1HashString(params.OldPassword) != user.Password {
		return errors.New400Response("旧密码不正确")
	}

	params.NewPassword = util.SHA1HashString(params.NewPassword)
	return a.UserModel.UpdatePassword(ctx, userID, params.NewPassword)
}
