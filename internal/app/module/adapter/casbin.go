package adapter

import (
	"context"
	"fmt"

	casbinModel "github.com/casbin/casbin/v2/model"
	"github.com/casbin/casbin/v2/persist"
	"github.com/google/wire"
	"github.com/sirupsen/logrus"

	"github.com/LyricTian/gin-admin/internal/app/model"
	"github.com/LyricTian/gin-admin/internal/app/schema"
	"github.com/LyricTian/gin-admin/pkg/logger"
)

var _ persist.Adapter = (*CasbinAdapter)(nil)

// CasbinAdapterSet 注入CasbinAdapter
var CasbinAdapterSet = wire.NewSet(wire.Struct(new(CasbinAdapter), "*"), wire.Bind(new(persist.Adapter), new(*CasbinAdapter)))

// CasbinAdapter casbin适配器
type CasbinAdapter struct {
	RoleModel         model.IRole
	RoleMenuModel     model.IRoleMenu
	MenuResourceModel model.IMenuActionResource
	UserModel         model.IUser
	UserRoleModel     model.IUserRole
}

// LoadPolicy loads all policy rules from the storage.
func (a *CasbinAdapter) LoadPolicy(model casbinModel.Model) error {

	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model=%+v", model)
	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model[e][e]=%+v", model["e"]["e"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model[g][g]=%+v", model["g"]["g"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model[m][m]=%+v", model["m"]["m"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model[p][p]=%+v", model["p"]["p"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 1 model[r][r]=%+v", model["r"]["r"])

	ctx := context.Background()
	err := a.loadRolePolicy(ctx, model)
	if err != nil {
		logger.Errorf(ctx, "Load casbin role policy error: %s", err.Error())
		return err
	}

	err = a.loadUserPolicy(ctx, model)
	if err != nil {
		logger.Errorf(ctx, "Load casbin user policy error: %s", err.Error())
		return err
	}

	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model=%+v", model)
	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model[e][e]=%+v", model["e"]["e"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model[g][g]=%+v", model["g"]["g"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model[m][m]=%+v", model["m"]["m"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model[p][p]=%+v", model["p"]["p"])
	//logrus.Debugf("CasbinAdapter LoadPolicy 2 model[r][r]=%+v", model["r"]["r"])

	return nil
}

// 加载角色策略(p,role_id,path,method)
func (a *CasbinAdapter) loadRolePolicy(ctx context.Context, m casbinModel.Model) error {

	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m=%+v", m)
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[e][e]=%+v", m["e"]["e"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[g][g]=%+v", m["e"]["e"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[m][m]=%+v", m["m"]["m"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[p][p]=%+v", m["p"]["p"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[r][r]=%+v", m["r"]["r"])

	roleResult, err := a.RoleModel.Query(ctx, schema.RoleQueryParam{
		Status: 1,
	})
	if err != nil {
		return err
	} else if len(roleResult.Data) == 0 {
		return nil
	}

	// logrus.Debugf("CasbinAdapter loadRolePolicy roleResult=%+v",roleResult)
	// logrus.Debugf("CasbinAdapter loadRolePolicy roleResult.Data=%v",roleResult.Data)
	for sK, sV := range roleResult.Data {
		logrus.Debugf("CasbinAdapter loadRolePolicy roleResult.Data sK=%+v sV=%+v", sK, sV)
	}

	roleMenuResult, err := a.RoleMenuModel.Query(ctx, schema.RoleMenuQueryParam{})
	if err != nil {
		return err
	}

	// logrus.Debugf("CasbinAdapter loadRolePolicy roleMenuResult=%+v",roleMenuResult)
	// logrus.Debugf("CasbinAdapter loadRolePolicy roleMenuResult.Data=%+v",roleMenuResult.Data)
	for sK, sV := range roleMenuResult.Data {
		logrus.Debugf("CasbinAdapter loadRolePolicy roleMenuResult.Data sK=%+v sV=%+v", sK, sV)
	}

	mRoleMenus := roleMenuResult.Data.ToRoleIDMap()

	// logrus.Debugf("CasbinAdapter loadRolePolicy mRoleMenus=%+v",mRoleMenus)
	for mK, mV := range mRoleMenus {
		logrus.Debugf("CasbinAdapter loadRolePolicy mRoleMenus mK=%+v", mK)
		for sK, sV := range mV {
			logrus.Debugf("CasbinAdapter loadRolePolicy mRoleMenus mK=%+v sK=%+v sV=%+v", mK, sK, sV)
		}
	}

	menuResourceResult, err := a.MenuResourceModel.Query(ctx, schema.MenuActionResourceQueryParam{})
	if err != nil {
		return err
	}

	// logrus.Debugf("CasbinAdapter loadRolePolicy menuResourceResult=%+v",menuResourceResult)
	// logrus.Debugf("CasbinAdapter loadRolePolicy menuResourceResult.Data=%+v",menuResourceResult.Data)
	for sK, sV := range menuResourceResult.Data {
		logrus.Debugf("CasbinAdapter loadRolePolicy menuResourceResult.Data sK=%+v sV=%+v", sK, sV)
	}

	mMenuResources := menuResourceResult.Data.ToActionIDMap()

	// logrus.Debugf("CasbinAdapter loadRolePolicy mMenuResources=%+v",mMenuResources)
	for mK, mV := range mMenuResources {
		logrus.Debugf("CasbinAdapter loadRolePolicy mMenuResources mK=%+v", mK)
		for sK, sV := range mV {
			logrus.Debugf("CasbinAdapter loadRolePolicy mMenuResources mK=%+v sK=%+v sV=%+v", mK, sK, sV)
		}
	}

	mcache := make(map[string]struct{})
	for _, item := range roleResult.Data {
		if rms, ok := mRoleMenus[item.RecordID]; ok { // item.RecordID 5eaaa01912a12014ac2b6ef1 角色id rms长度为7
			logrus.Debugf("rms.ToActionIDs()=%+v", rms.ToActionIDs())
			// "rms.ToActionIDs()=[ 5eaa744cec65f5408adfa49c 5eaa744cec65f5408adfa49a 5eaa744cec65f5408adfa498 5eaa744cec65f5408adfa496 5eaa744cec65f5408adfa493 5eaa744cec65f5408adfa491]"
			for _, actionID := range rms.ToActionIDs() { // action_id
				if mrs, ok := mMenuResources[actionID]; ok {
					for _, mr := range mrs {
						if mr.Path == "" || mr.Method == "" {
							continue
						} else if _, ok := mcache[mr.Path+mr.Method]; ok {
							continue
						}
						mcache[mr.Path+mr.Method] = struct{}{}
						line := fmt.Sprintf("p,%s,%s,%s", item.RecordID, mr.Path, mr.Method)
						logrus.Debugf("CasbinAdapter loadRolePolicy line=%+v", line)
						persist.LoadPolicyLine(line, m)
					}
				}
			}
		}
	}

	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m=%+v", m)
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[e][e]=%+v", m["e"]["e"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[g][g]=%+v", m["e"]["e"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[m][m]=%+v", m["m"]["m"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[p][p]=%+v", m["p"]["p"])
	logrus.Debugf("CasbinAdapter loadRolePolicy casbinModel.Model m[r][r]=%+v", m["r"]["r"])

	return nil
}

// 加载用户策略(g,user_id,role_id)
func (a *CasbinAdapter) loadUserPolicy(ctx context.Context, m casbinModel.Model) error {
	userResult, err := a.UserModel.Query(ctx, schema.UserQueryParam{
		Status: 1,
	})
	if err != nil {
		return err
	} else if len(userResult.Data) == 0 {
		return nil
	}

	// logrus.Debugf("CasbinAdapter loadUserPolicy userResult=%+v",userResult)
	logrus.Debugf("CasbinAdapter loadUserPolicy userResult.Data=%+v", userResult.Data)

	userRoleResult, err := a.UserRoleModel.Query(ctx, schema.UserRoleQueryParam{})
	if err != nil {
		return err
	}

	// logrus.Debugf("CasbinAdapter loadUserPolicy userRoleResult=%+v",userRoleResult)
	for sK, sV := range userRoleResult.Data {
		logrus.Debugf("CasbinAdapter loadUserPolicy userRoleResult.Data sK=%+v sV=%+v", sK, sV)
	}

	mUserRoles := userRoleResult.Data.ToUserIDMap()

	// logrus.Debugf("CasbinAdapter loadUserPolicy mUserRoles=%+v",mUserRoles)
	for mK, mV := range mUserRoles {
		logrus.Debugf("CasbinAdapter loadUserPolicy mUserRoles mK=%+v", mK)
		for sK, sV := range mV {
			logrus.Debugf("CasbinAdapter loadUserPolicy mUserRoles mK=%+v sK=%+v sV=%+v", mK, sK, sV)
		}
	}

	for _, uitem := range userResult.Data {
		if urs, ok := mUserRoles[uitem.RecordID]; ok {
			for _, ur := range urs {
				line := fmt.Sprintf("g,%s,%s", ur.UserID, ur.RoleID)
				logrus.Debugf("CasbinAdapter loadUserPolicy line=%+v", line)
				persist.LoadPolicyLine(line, m)
			}
		}
	}

	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m=%+v", m)
	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m[e][e]=%+v", m["e"]["e"])
	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m[g][g]=%+v", m["g"]["g"])
	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m[m][m]=%+v", m["m"]["m"])
	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m[p][p]=%+v", m["p"]["p"])
	logrus.Debugf("CasbinAdapter loadUserPolicy casbinModel.Model m[r][r]=%+v", m["r"]["r"])

	return nil
}

// SavePolicy saves all policy rules to the storage.
func (a *CasbinAdapter) SavePolicy(model casbinModel.Model) error {
	return nil
}

// AddPolicy adds a policy rule to the storage.
// This is part of the Auto-Save feature.
func (a *CasbinAdapter) AddPolicy(sec string, ptype string, rule []string) error {
	return nil
}

// RemovePolicy removes a policy rule from the storage.
// This is part of the Auto-Save feature.
func (a *CasbinAdapter) RemovePolicy(sec string, ptype string, rule []string) error {
	return nil
}

// RemoveFilteredPolicy removes policy rules that match the filter from the storage.
// This is part of the Auto-Save feature.
func (a *CasbinAdapter) RemoveFilteredPolicy(sec string, ptype string, fieldIndex int, fieldValues ...string) error {
	return nil
}
