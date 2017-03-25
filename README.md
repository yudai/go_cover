# Go coverage with -coverpkg

This repository demonstrates how the `-coverpkg` option works when you get test coverage of your projects.

This project has two packages, one is pkg1 and the other is pkg2. The pkg1 has enough tests, it's actually 100%. On the other hand, the pkg2 has no tests.

`without_coverpkg.sh` calculates the "total" coverage using `go test` commands without `-coverpkg`. `with_coverpkg.sh` does the same thing with the `-coverpkg` option. The script lists up dependency packages in the project and pass that to the `-coverpkg` option.

# Outputs

```shell
yudai@yudai01% ./without_coverpkg.sh
?       github.com/yudai/go_cover       [no test files]
=== RUN   TestPkg1
--- PASS: TestPkg1 (0.00s)
PASS
coverage: 100.0% of statements
ok      github.com/yudai/go_cover/pkg1  1.014s
?       github.com/yudai/go_cover/pkg2  [no test files]
github.com/yudai/go_cover/pkg1/pkg1.go:7:       DoSomething     100.0%
github.com/yudai/go_cover/pkg1/pkg1.go:15:      DoSomethingElse 100.0%
github.com/yudai/go_cover/pkg1/pkg1.go:23:      CallPkg2        100.0%
total:                                          (statements)    100.0%
```

We don't have any tests for `pkg2`, but the shown coverage is 100%.


```shell
yudai@yudai01% ./with_coverpkg.sh
warning: no packages being tested depend on github.com/yudai/go_cover/pkg1
warning: no packages being tested depend on github.com/yudai/go_cover/pkg2
?       github.com/yudai/go_cover       [no test files]
warning: no packages being tested depend on github.com/yudai/go_cover
=== RUN   TestPkg1
--- PASS: TestPkg1 (0.00s)
PASS
coverage: 51.9% of statements in github.com/yudai/go_cover, github.com/yudai/go_cover/pkg1, github.com/yudai/go_cover/pkg2
ok      github.com/yudai/go_cover/pkg1  1.019s
warning: no packages being tested depend on github.com/yudai/go_cover
warning: no packages being tested depend on github.com/yudai/go_cover/pkg1
?       github.com/yudai/go_cover/pkg2  [no test files]
github.com/yudai/go_cover/main.go:3:            main            0.0%
github.com/yudai/go_cover/pkg1/pkg1.go:7:       DoSomething     100.0%
github.com/yudai/go_cover/pkg1/pkg1.go:15:      DoSomethingElse 100.0%
github.com/yudai/go_cover/pkg1/pkg1.go:23:      CallPkg2        100.0%
github.com/yudai/go_cover/pkg2/pkg2.go:3:       DoSomething     30.0%
github.com/yudai/go_cover/pkg2/pkg2.go:18:      DoSomethingElse 0.0%
total:                                          (statements)    51.9%
```

Now you see the real total coverage.

# Conclusion

It's good to have `-coverpkg` option in the script to calculate the project-wide test coverage. It can revial hidden untested packages.

However, when you want to see if each package has enough unit tests, you don't want to use the `-coverpkg` option, becasue it makes the test comand output "integrated" coverages.
