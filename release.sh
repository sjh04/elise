# $1 directory
function pack() {
  cd "$1/" || exit
  zip -r "../$1.zip" *
  cd ../
}

GOOS=linux go build -ldflags "-w -s -X 'main.version=$1'" -o release/linux/elise cmd/elise/main.go
GOOS=darwin GOARCH=amd64 go build -ldflags "-w -s -X 'main.version=$1'" -o release/darwin/elise_amd64 cmd/elise/main.go
GOOS=darwin GOARCH=arm64 go build -ldflags "-w -s -X 'main.version=$1'" -o release/darwin/elise_arm64 cmd/elise/main.go
GOOS=windows go build -ldflags "-w -s -X 'main.version=$1'" -o release/windows/elise.exe cmd/elise/main.go

cd release || exit

pack "linux"
pack "darwin"
pack "windows"