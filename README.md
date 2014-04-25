Voteline
========

Voteline is a real-time voting application that shows voting history as a function of time.

Dependencies
============

Voteline was developed on Ruby v2.1 and Rails v4.1.  Several gems were utilized to make development easier:

```ruby
gem 'devise'
gem 'draper'
gem 'lazy_high_charts'
```

Installation
============

1. Clone the repository.
2. Create a `/config/secrets.yml` file with with your private keys for development, test, and production environments and add it to your `.gitignore` file.

```ruby
development:
  secret_key_base: 3acf07
  devise_secret_key: 3ef655

test:
  secret_key_base: 6035fd
  devise_sceret_key: 8701cb

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  devise_secret_key: <%= ENV["DEVISE_SECRET_KEY"] %>
```

3. If deploying to Heroku, add these environmental variables to your production environment: `$ heroku config:set RAILS_SECRET_KEY_BASE=1234abcd`
4. If deploying to Heroku, pick an email provider. Sendgrid is easy: `$ heroku addons:add sendgrid:starter`
5. Copy the new sendgrid configuration variables to your `/config/secrets.yml` file.
6. Add the following to your config/environment.rb file:

```ruby
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
```
7. As of v3.1.0, Devise requires the secret key be available during asset precompilation. Heroku's Cedar stack doesn't support this by default, but you can enable it using the `$ heroku labs:enable user-env-compile -a <appname>` command.

TODO
====

* Poll admins
* Realtime updating (websockets perhaps?)

Credits
=======

Voteline is the product of [Ryan Ringler](http://github.com/rringler).  It was developed largerly as a pet project to continue to learn and better understand rails.

License
=======

Voteline is licensed under the MIT License.  Please see the [LICENSE](http://github.com/rringler/voteline/LICENSE) file for additional details.
