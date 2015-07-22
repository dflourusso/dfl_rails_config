group :production do
  gem 'rails_12factor' # https://devcenter.heroku.com/articles/getting-started-with-rails4#heroku-gems
  gem 'pg' # https://devcenter.heroku.com/articles/getting-started-with-rails4#use-postgres
  gem 'unicorn' # https://devcenter.heroku.com/articles/getting-started-with-rails4#webserver
end
