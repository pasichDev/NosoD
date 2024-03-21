package config

import (
	"log"
	"os"
	"path/filepath"

	"NosoHive/internal/paths"

	"github.com/ilyakaznacheev/cleanenv"
)

type Config struct {
	Env     string `yaml:"env" env-default:"release"`
	MyIp    string `yaml:"my_ip" env-required:"true"`
	DNSSeed string `yaml:"dns_seed" env-required:"true"`
	RPC     `yaml:"rpc"`
}

type RPC struct {
	Active   string `yaml:"active" env-default:"false"`
	Address  string `yaml:"address" env-default:"localhost"`
	Port     int    `yaml:"port" env-default:"8073"`
	User     string `yaml:"user"`
	Password string `yaml:"password"`
}

func MustLoad() *Config {
	executablePath, err := os.Executable()
	if err != nil {
		log.Fatalf("cannot determine executable path: %s", err)
	}

	configPath := filepath.Join(filepath.Dir(executablePath), paths.Config)

	// check if file exists
	if _, err := os.Stat(configPath); os.IsNotExist(err) {
		log.Fatalf("config file does not exist: %s", configPath)
	}

	var cfg Config

	if err := cleanenv.ReadConfig(configPath, &cfg); err != nil {
		log.Fatalf("cannot read config: %s", err)
	}

	return &cfg
}
