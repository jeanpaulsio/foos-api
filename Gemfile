source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.7'
gem 'bcrypt', '~> 3.1.7'
gem 'knock',  '~> 2.1', '>= 2.1.1'
gem 'pg',     '~> 0.18'
gem 'puma',   '~> 3.7'
gem 'rails',  '~> 5.1.4'
gem 'redis',  '~> 3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'minitest-reporters', '~> 1.1', '>= 1.1.19'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
