package main

import (
	"log/slog"
	"os"
	"testing"
)

var app application

func TestMain(m *testing.M) {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
	app.logger = logger
	os.Exit(m.Run())

}
