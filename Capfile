# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require "capistrano/rbenv"
require "capistrano/bundler"
require "whenever/capistrano"
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
