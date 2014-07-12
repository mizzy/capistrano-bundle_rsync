# config valid only for Capistrano 3.2.1
lock '3.2.1'

set :user, 'game'
set :ssh_options, user: ENV['USER'], keys: [File.expand_path('~/.ssh/id_rsa')]
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system tmp/run)
set :keep_releases, 5
set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'
set :deploy_to, "#{ENV['HOME']}/sample"

set :scm, :bundle_rsync
set :bundle_rsync_max_parallels, ENV['PARA']
set :bundle_rsync_rsync_bwlimit, ENV['BWLIMIT'] # like 20000

namespace :deploy do
  desc 'Restart web application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # execute some restart code
    end
  end

  after :finishing, 'deploy:cleanup'
  # after :publishing, :restart
end