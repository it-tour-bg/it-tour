namespace :database do
  desc 'Import the latest database from tmp directory'
  task import: %i(environment) do
    file_path = Dir[Rails.root.join('db', 'it*.sql')].last

    raise 'Missing database file at db' unless file_path.present?

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    config = Rails.configuration.database_configuration['development']

    Bundler.clean_system format('cat %s | PGPASSWORD=%s psql -h %s -p %d -U %s -d %s', file_path, config['password'], config['host'], config['port'], config['username'], config['database'])
  end
end

