# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "proposals"
set :repo_url, "https://github.com/birs-math/proposals.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to

# Default value for :format is :airbrussh.
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


namespace :deploy do
  desc "deploy the app"
  task :copyfiles do
    on roles(:app) do
      execute "cp #{shared_path}/root/* #{release_path}/"
      execute "cp -R #{shared_path}/public/* #{release_path}/"
      # execute "rsync -aLv #{shared_path}/lib/ #{release_path}/lib/"
      # execute "rsync -aLv #{shared_path}/app/ #{release_path}/app/"
    end
  end

  task :remove_old do
    on roles(:app), :on_error => :continue do
      execute "docker stop proposals && sleep 5"
      execute "docker rm proposals && sleep 2"
    end
  end

  task :run do
    on roles(:app) do
      execute "docker start proposals_db"
      execute "docker pull birs/proposals:latest"
      execute "cd #{release_path} && docker-compose up -d"
    end
  end

  after :publishing, 'deploy:copyfiles'
  after :publishing, 'deploy:remove_old'
  after :publishing, 'deploy:run'
end


