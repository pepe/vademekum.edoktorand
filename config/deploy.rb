require 'mina/bundler'
require 'mina/git'
require 'mina/rvm'

set :domain, 'edoktorand.czu.cz'
set :deploy_to, '/usr/home/deploy/vademekum.edoktorand.czu.cz'
set :repository, 'git://github.com/pepe/vademekum.edoktorand'
set :branch, 'master'

set :user, 'deploy'

task :environment do
  invoke :'rvm:use[ruby-1.9.3-p327@vademekum]'
end

set :shared_paths, ['log', 'public/sheets']

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
  queue! %[mkdir -p "#{deploy_to}/shared/public/sheets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/sheets"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    to :launch do
      queue "thin -C #{deploy_to}/shared/thin.yml restart"
    end
  end
end

