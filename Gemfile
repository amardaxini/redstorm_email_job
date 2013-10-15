source 'https://rubygems.org'

platform :jruby do
  gem 'redstorm'
  gem 'pry'
end

platform :mri  do
  #gem 'twitter-stream', '~> 0.1.16'
  gem 'redis'
  gem 'hiredis'
  gem 'mailcatcher'
  
end


group :test do
  gem 'rake'
  gem 'rspec', '~> 2.11.0'
end
gem 'pry'

group :topology do
  gem 'redis',  :platforms => :jruby
  gem 'json', :platforms => :jruby
  gem 'pry',:platform=>:jruby
  gem 'mail'
end