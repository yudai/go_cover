package pkg1

import (
	"github.com/yudai/go_cover/pkg2"
)

func DoSomething() {
	x := 0
	x++
	x++
	x++
	x++
}

func DoSomethingElse() {
	y := 0
	y++
	y++
	y++
	y++
}

func CallPkg2() {
	pkg2.DoSomething(0)
}
