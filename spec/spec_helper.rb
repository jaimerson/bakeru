$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '..')
require 'rubygems'
require 'bundler/setup'

Bundler.setup
$LOAD_PATH << './src'

require 'gosu'
require 'pry'

ENV['GOSU_ENV'] = 'test'

if ENV['CRYSTALBALL_MAP'] == 'true'
  require 'crystalball'

  Crystalball::MapGenerator.start! do |c|
    c.register Crystalball::MapGenerator::AllocatedObjectsStrategy.build(only: %w[ActiveRecord::Base])
    c.register Crystalball::MapGenerator::CoverageStrategy.new
    c.register Crystalball::MapGenerator::DescribedClassStrategy.new
    c.commit = ENV['GIT_COMMIT'] if ENV['GIT_COMMIT']
    c.version = 1
    c.map_storage_path = "tmp/execution_map.yml"
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  Kernel.srand config.seed
end
