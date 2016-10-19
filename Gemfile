source 'https://gems.ruby-china.org'

gem "rails", "4.2.7.1"
gem "uglifier", ">= 1.3.0"
gem "turbolinks"
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'puma', '~> 3.0'

gem 'sass-rails', '~> 5.0'
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "haml"
gem "kaminari", "~> 0.15.1"

gem "devise", "3.5.2"

gem 'sprockets', '3.4.0'
gem 'sprockets-rails', '2.3.3'

# 修正 assets 的冗余 digest 问题
gem 'non-stupid-digest-assets'


# https://github.com/reactjs/react-rails
# 引入 reactjs
gem 'react-rails', '~> 1.8.2'
# https://github.com/browserify-rails/browserify-rails
# https://github.com/mindpin/knowledge-camp/issues/170
gem 'browserify-rails'
# 支持 asset require coffee 文件
gem 'sprockets-coffee-react', '3.0.1'


group :development do
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'pry-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem "database_cleaner", "~> 1.2.0"
end

gem "unicorn"
gem "mongoid", "~> 4.0.0"
gem "mina", "0.3.7"
gem "figaro", "~> 1.1.1"

gem 'file-part-upload', github: "mindpin/file-part-upload",
                        tag: "3.2.0"