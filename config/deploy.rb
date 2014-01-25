lock '3.1.0'

set :application,         'ittour'
set :scm,                 :git
set :repo_url,            'git@github.com:RStankov/it-tour.git'
set :branch,              'master'
set :deploy_to,           '/home/ittour/www/ittour'
set :linked_files,        %w(config/database.yml)
set :linked_dirs,         %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute 'bin/pumactl', '--state', release_path.join('tmp/puma.state'), 'restart'
      end
    end
  end

  after :publishing, :restart
end
