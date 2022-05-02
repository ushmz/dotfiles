# Cheat Sheet

## vim-go

- `<leader>b`         : GoBuild = `go build`
- `<leader>r`         : GoRun = `go run`
- `<leader>t`         : GoTest = `go test`
- `<leader>tf`        : GoTestFunc = `go test -run ...`
- `<leader>c`         : GoCoverageToggle
- `<leader>ga`        : GoAlternate = foo.go と foo_test.goを行き来する
- `:GoImport ${name}` : importに追加、tab補完可能
- `:GoDrop ${name}`   : importから削除、tab補完可能
- `:GoImports`        : 不足しているパッケージをimportに追加する
- `[y, c, d, v]if`    : 関数の中身を処理
- `[y, c, d, v]af`    : 関数の全体を処理
