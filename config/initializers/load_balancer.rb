require "yaml"
require_relative "../../lib/api/load_balancer"

config = YAML.load(File.read("config/load_balancer.yml"), symbolize_names: true)
config ||= {}
Api::LoadBalancer.init(**config)
