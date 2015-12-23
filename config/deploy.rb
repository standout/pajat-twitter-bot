# config valid only for current version of Capistrano
lock "3.4.0"

set :application, "pajat_twitter_bot"
set :repo_url, "git@github.com:standout/pajat-twitter-bot.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/pajat_twitter_bot"

# Default value for :pty is false
# set :pty, true

set :linked_files, fetch(:linked_files, []).push(".env")

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

set :rbenv_ruby, "#{File.read('.ruby-version').chomp}"
set :rbenv_type, :user
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
