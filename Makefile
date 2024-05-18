APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=kmihailvdxc
VERSION=$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

build: format
	go get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/kmikhailv/kbot/cmd.appVersion=${VERSION}

clean:
	rm -rf kbot

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}


linux: format
	go get
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/kmikhailv/kbot/cmd.appVersion=${VERSION}

linux_arm: format
	go get
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/kmikhailv/kbot/cmd.appVersion=${VERSION}

macos: format
	go get
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/kmikhailv/kbot/cmd.appVersion=${VERSION}

windows: format
	go get
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/kmikhailv/kbot/cmd.appVersion=${VERSION}

image_linux:
	docker build --build-arg build_target=linux . -t ${REGISTRY}/${APP}:${VERSION}-linux

image_linux_arm:
	docker build --build-arg build_target=linux_arm . -t ${REGISTRY}/${APP}:${VERSION}-linux_arm

image_macos:
	docker build --build-arg build_target=macos . -t ${REGISTRY}/${APP}:${VERSION}-macos

image_windows:
	docker build --build-arg build_target=windows . -t ${REGISTRY}/${APP}:${VERSION}-windows
