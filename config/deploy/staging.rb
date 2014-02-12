server 'marla.ludost.net', user: 'ittour', roles: %w(web app db)

set :branch,    'staging'
set :deploy_to, '/home/ittour/www/ittour-staging'
set :rails_env, 'production'
