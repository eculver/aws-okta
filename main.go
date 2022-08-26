package main

import (
	"github.com/eculver/aws-okta/cmd"
)

// These are set via linker flags
var (
	Version           = "dev"
	AnalyticsWriteKey = ""
)

func main() {
	// vars set by linker flags must be strings...
	cmd.Execute(Version, AnalyticsWriteKey)
}
