lock '3.6.0'

# デプロイするアプリケーション名
set :application, 'simpleblog'

# cloneするgitのレポジトリ（xxxxxxxx：ユーザ名、yyyyyyyy：アプリケーション名）
#set :repo_url, 'https://github.com/kenmurata/yyyyyyyy'
#set :repo_url, 'https://bitbucket.org/ken_murata/simpleblog'
set :repo_url, 'git@bitbucket.org:ken_murata/simpleblog.git'

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, ENV['BRANCH'] || 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/simpleblog'

# シンボリックリンクをはるフォルダ・ファイル
set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# Rubyのバージョン
set :rbenv_ruby, '2.3.0'
###set :rbenv_ruby, '2.3.0'
set :rbenv_type, :system

#出力するログのレベル。
set :log_level, :debug

# wheneverによるcrontabの設定
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }


namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end
  desc 'Generate sitemap'
  task :sitemap do
    on roles(:app) do
      within release_path do
        execute :bundle, :exec, :rake, 'sitemap:create RAILS_ENV=production'
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
  
  after :deploy, "deploy:sitemap"
end