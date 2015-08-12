namespace :database do
  desc 'Import the latest database from tmp directory'
  task import: %i(environment) do
    database_name = Rails.configuration.database_configuration['development']['database']
    file_path = Dir[Rails.root.join('db', 'it*.sql')].last

    raise 'Missing database file at db' unless file_path.present?

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    Bundler.clean_system "cat #{file_path} | psql #{database_name}"
  end
end

