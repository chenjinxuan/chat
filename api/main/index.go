package main

import "./data"
import (
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"strconv"
)

type MainController struct {
	beego.Controller
}
type msgPack struct {
	MainID int
	SubID  int
	Args   interface{}
}

func (this *MainController) Get() {
	mainID, _ := strconv.Atoi(this.Ctx.Input.Param(":mainID"))
	subID, _ := strconv.Atoi(this.Ctx.Input.Param(":subID"))

	ret := msgPack{MainID: mainID, SubID: subID}
	ret.Args = DealMainID(mainID, subID)

	data, err := json.Marshal(ret)
	if err != nil {
		fmt.Println(err)
	}

	this.Ctx.WriteString(string(data))
}

func DealMainID(mainID int, subID int) interface{} {

	switch mainID {
	case 1:
		return DealSubID(subID)
	}
	return ""
}

func DealSubID(subID int) interface{} {
	return "nihao"
}

func main() {
	data.RegisterDB();
	beego.Router("/?:mainID([0-9]+)/?:subID([0-9]+)", &MainController{})
	beego.Run()


}
