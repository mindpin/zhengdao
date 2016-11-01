require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :domain, '101.201.76.76'
set :deploy_to, '/web/zhengdao'
set :current_path, 'current'
set :repository, 'git://github.com/mindpin/zhengdao.git'
set :branch, 'master'
set :user, 'root'
set :term_mode, nil

set :shared_paths, [
  'config/mongoid.yml',
  'config/secrets.yml',
  'config/application.yml',
  'tmp',
  'log'
]

task :environment do
end

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

  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue  %[echo "-----> Be sure to edit 'shared/config/mongoid.yml'."]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]
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
        yarn install
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