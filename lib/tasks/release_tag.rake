namespace :staging do
  task :default => 'staging:release_tag'

  desc "Update timestamp on staging server"
  task :release_tag => :environment do
    timestamp = Time.now - 7.hours
    timestamp = timestamp.strftime('%Y-%m-%d %H:%M')
    puts "Setting release tag to: #{timestamp} PDT"
    exec("sed -i \"s/TIMESTAMP/#{timestamp}\ PDT/g\" /home/app/proposals/app/views/layouts/_sidebar.html.erb")
  end
end
