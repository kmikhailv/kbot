APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=kmihailvdxc
VERSION=$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

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

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}