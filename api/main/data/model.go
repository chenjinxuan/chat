package data

import (
	"github.com/astaxie/beego/orm"
)

type Account struct {
	Id              int
	AccountID       string
	AccountPassword string
	Name            string
}

func RegisterDB() {
	//注册 model
	//orm.RegisterModel(new(Store), new(Customer))
	orm.RegisterModel(new(Account))
	//注册驱动
	_ = orm.RegisterDriver("mysql", orm.DRMySQL)
	//注册默认数据库
	_ = orm.RegisterDataBase("default", "mysql", "root:root@/chat?charset=utf8") //密码为空格式

}
