
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
