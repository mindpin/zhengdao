require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :domain, '124.115.26.218'
set :deploy_to, '/web/knowledge-camp-mobile'
set :current_path, 'current'
set :repository, 'git://github.com/mindpin/knowledge-camp.git'
set :branch, 'mobile'
set :user, 'root'
set :term_mode, nil

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, [
  'config/mongoid.yml',
  'config/secrets.yml',
  'config/application.yml',
  'tmp',
  'log'
]

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/logs"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/logs"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]
  queue! %[touch "#{deploy_to}/shared/config/mongoid.yml"]
  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue! %[touch "#{deploy_to}/shared/config/application.yml"]

  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue  %[echo "-----> Be sure to edit 'shared/config/mongoid.yml'."]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]
  queue  %[echo "-----> Be sure to edit 'shared/config/application.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    to :launch do
      queue %[
        source /etc/profile
        bundle
        RAILS_ENV="production" bundle exec rake assets:precompile
        ./deploy/sh/unicorn.sh stop
        ./deploy/sh/unicorn.sh start
      ]
    end
  end

end

desc "update code only"
task :update_code => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    to :launch do
      queue %[
        source /etc/profile
        bundle
        RAILS_ENV="production" bundle exec rake assets:precompile
      ]
    end
  end
end

desc "restart server"
task :restart => :environment do
  queue %[
    source /etc/profile
    cd #{deploy_to}/#{current_path}
    ./deploy/sh/unicorn.sh stop
    ./deploy/sh/unicorn.sh start
  ]
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
