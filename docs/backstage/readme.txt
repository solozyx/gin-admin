
[V] 1.用户角色添加 判断了角色表 role_status         [数据正确]

[V] 2.角色权限添加 判断了权限表 permission_status   [数据正确]

3.service/user
    3.1 RoleAdd
    3.2 RoleReduce
        adapter.CasbinSyncedEnforcer.LoadPolicy()

4.service/role
    4.1 PermAdd
    4.2 PermReduce
        adapter.CasbinSyncedEnforcer.LoadPolicy()

5.service/user
    5.1 rolelist 下级用户看到了上级用户的角色列表
    5.2 permlist 下级用户看到了上级用户的权限列表

func InitTestRepo() {
	cfg := &common.Config{}
	cfg.MySql.Balance.User = "root"
	cfg.MySql.Balance.Password = "oben.com@123"
	cfg.MySql.Balance.Host = "127.0.0.1:3309"
	cfg.MySql.Balance.DataBase = "backstage"
	Init(cfg)
}


Mysql:
  Balance:
    Host: 127.0.0.1:3309
    User: root
    Password: oben.com@123
    DataBase: backstage


用户的角色列表接口

(user1,有系统管理员角色)
    -->user1创建了一级管理员角色1
        -->user2分配了一级管理员角色1-->user2创建了二级管理员角色1
查看user1拥有的角色列表
    结果1 [系统管理员角色,一级管理员角色1,二级管理员角色1]
    结果2 [系统管理员角色,一级管理员角色1]


(user11,有系统管理员角色)
    -->user11创建了一级管理员角色1
        -->user12 和 user13分配了一级管理员角色1 user12和user13同级
            -->user12创建了二级管理员角色1
查看user13拥有的角色列表
    结果1 [一级管理员角色1,二级管理员角色1]
    结果2 [一级管理员角色1]


----------------------------------------------------------------------

(root,有系统管理员角色) 能创建部门dep
    -->dep1user1 创建了 dep1一级管理员角色1
        -->dep1user2 分配了 dep1一级管理员角色1 --> user2创建了二级管理员角色1
查看user1拥有的角色列表
    结果1 [系统管理员角色,一级管理员角色1,二级管理员角色1]
    结果2 [系统管理员角色,一级管理员角色1]


(user11,有系统管理员角色)
    -->user11创建了一级管理员角色1
        -->user12 和 user13分配了一级管理员角色1 user12和user13同级
            -->user12创建了二级管理员角色1
查看user13拥有的角色列表
    结果1 [一级管理员角色1,二级管理员角色1]
    结果2 [一级管理员角色1]

