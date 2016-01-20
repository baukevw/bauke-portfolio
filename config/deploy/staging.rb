set :stage, :staging

role :app, %w{178.62.214.132:3001}
role :web, %w{178.62.214.132:3001}
role :db,  %w{178.62.214.132:3001}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '178.62.214.132:3001', user: 'deploy', roles: %w{web app db}

set :deploy_to, "/home/deploy/railsapps/baukeme/staging/current/public"

set :rails_env, 'development'
set :branch, 'develop'
