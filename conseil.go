//go:generate go-bindata -o templates.go templates/...
//go:generate sed -i .bak "s/main/conseil/" templates.go
package conseil
