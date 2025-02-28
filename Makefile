# Goals:
# - user can build binaries on their system without having to install special tools
# - user can fork the canonical repo and expect to be able to run CircleCI checks
#
# This makefile is meant for humans

VERSION := $(shell git describe --tags --always --dirty="-dev")
LDFLAGS := -ldflags='-X "main.Version=$(VERSION)"'

# WindowsMSI building with WiX Toolset requires semantic versioning
# Storing build version in text file at repo root in the form major.minor.patch 
WINVERSION := $(shell cat version)

test:
	go test -v ./...

all: dist/aws-okta-$(VERSION)-darwin-amd64 dist/aws-okta-$(VERSION)-linux-amd64

clean:
	rm -rf ./dist

dist/: 
	mkdir -p dist

dist/aws-okta-$(VERSION)-darwin-amd64: | dist/
	GOOS=darwin GOARCH=amd64 go build $(LDFLAGS) -o $@

dist/aws-okta-$(VERSION)-linux-amd64: | dist/
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $@

dist/aws-okta-$(VERSION).exe: | dist/
	GOOS=windows GOARCH=amd64 go build $(LDFLAGS) -o dist/aws-okta.exe

.PHONY: clean all
