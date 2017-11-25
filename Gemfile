source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootstrap-sass", "~> 3.3.7"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "devise"
gem "faker"
gem "font-awesome-sass", "~> 4.7.0"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.4"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platform: :mri
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "mysql2", ">= 0.3.18", "< 0.5"
	gem "pry"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg"
  gem "rails_12factor"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "rails_admin"
