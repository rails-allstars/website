$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
require "bundler/capistrano"

# BASE APP CONFIG
# ===============
set :application, "railsallstars"
set :rails_env, 'staging'
set :port, 2200  # VM: mailistic.empuxa.com
serveraddr = "vmhost.empuxa.com"

set :rvm_ruby_string, "ruby-1.9.2-p290@#{application}_#{rails_env}"
set :rvm_type, :user

set :scm, :git
set :scm_user, 'gitolite'
set :branch, 'master'
set :user, 'www-data'

set :repository,  'git@github.com:rails-allstars/website.git'

set :use_sudo, false
set :app_port, '7280'

set :deploy_to, "/var/www/apps/#{application}_#{rails_env}"
set :deploy_via, :remote_cache
set :ssh_options, {:forward_agent => true}

role :app, serveraddr, :primary => true
role :web, serveraddr, :primary => true
role :db, serveraddr, :primary => true
set :normalize_asset_timestamps, false


after 'deploy:update_code' do
  run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} rake assets:precompile"
end


namespace :deploy do
  pid_file = "#{deploy_to}/shared/pids/passenger.#{app_port}.pid"
  log_file = "#{deploy_to}/shared/log/passenger.#{app_port}.pid"
  start_command = "passenger start #{current_path} -d -e #{rails_env} --port #{app_port} --pid-file=#{pid_file} --log-file=#{log_file}"
  stop_command = "passenger stop #{current_path} --port #{app_port} --pid-file=#{pid_file}"
  task :start do
    run start_command
  end
  
  task :stop do
    run stop_command
  end
  
  task :restart do
    run stop_command
    run start_command
  end
  
  desc "Symlink the config files."
  after "deploy:symlink", "deploy:symlink_configs"
  task :symlink_configs do
    run "echo symlinking everything to #{release_path}"
    
    run "rm -fr #{release_path}/tmp"
    run "mkdir -p #{deploy_to}/shared/tmp/"
    run "ln -s #{deploy_to}/shared/tmp/ #{release_path}/tmp"

    run "rm -fr #{release_path}/config/database.yml"
    run "mkdir -p #{deploy_to}/shared/config/"
    run "ln -s  #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    
  end
  
  
  #after "deploy:symlink", "deploy:update_crontab"
  #desc "Update the crontab file"
  #task :update_crontab, :roles => :db do
  #  run "cd #{current_path} && bundle exec whenever --update-crontab #{application}"
  #end
  
end

namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} rake #{ENV['task']}"
  end  
end



