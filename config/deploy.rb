require 'capistrano-db-tasks'

lock '3.1.0'

set :application,         'ittour'
set :scm,                 :git
set :repo_url,            'git@github.com:RStankov/it-tour.git'
set :branch,              'master'
set :deploy_to,           '/home/ittour/www/ittour'
set :linked_files,        %w(config/database.yml .env)
set :linked_dirs,         %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute 'bin/pumactl', '--state', current_path.join('tmp/pids/puma.state'), 'restart'
      end
    end
  end

  after :publishing, :restart
end

namespace :db do
  desc 'Fetches remote database and stores it.'
  task :fetch do
    on roles(:db) do
      remote_db = Database::Remote.new(self)
      remote_db.dump.download

      output_file = remote_db.output_file
      unless output_file.empty?
        execute "rm -f #{current_path}/#{output_file}"
      end
    end
  end
end
