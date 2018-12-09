package main

import (
	"chat/common/services"

	cli "gopkg.in/urfave/cli.v2"
)

func startup(c *cli.Context) {
	go sig_handler()
	services.Init(c)
}
