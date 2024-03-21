package main

import (
	"fmt"
	"log"

	"NosoHive/internal/config"
)

const (
	envDev  = "dev"
	envProd = "prod"
)

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {

	cfg := config.MustLoad()
	fmt.Printf("Running http server on %s\n", cfg.MyIp)

	//	ctx := context.Background()

	//	fmt.Printf("Running http server on %s\n", addr)

	//return err

	return nil
}
