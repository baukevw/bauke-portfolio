# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'bauke-portfolio'
set :repo_url, 'git@github.com:baukevw/bauke-portfolio.git'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :keep_releases, 5
set :linked_dirs, fetch(:linked_dirs) + %w{public/system public/uploads}

#set :normalize_asset_timestamps, false
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after "deploy", "deploy:migrate"
end
