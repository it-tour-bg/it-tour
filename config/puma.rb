preload_app!

min_threads = (ENV['PUMA_MIN_THREADS'] || 20).to_i
max_threads = (ENV['PUMA_MAX_THREADS'] || 20).to_i
threads min_threads, max_threads

workers (ENV['PUMA_WORKERS'] || 3).to_i
state_path File.expand_path('../../tmp/pids/puma.state', __FILE__)

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # In seconds
    config['pool']              = ENV['DB_POOL'] || max_threads

    ActiveRecord::Base.establish_connection(config)
  end
end
