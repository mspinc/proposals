namespace :deploy do
  desc 'run deployment script on remote server'
  task :remote do
    on roles(:all) do |server|
      script = fetch(:remote_script)
      execute :sh, "#{script}"
    end
  end
end
