require 'active_record'
require 'yaml'

ActiveRecord::Base.establish_connection(
  YAML::load(File.open('config/database.yml'))[ENV['GOSU_ENV'] || 'development']
)

ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV['GOSU_DEBUG']
