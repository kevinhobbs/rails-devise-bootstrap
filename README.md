# Project Name
Rails-Devise-Bootstrap

## Overview
Create rails app with devise and bootstrap

## System Requirements
- Ruby 3.2.2
- Rails 7.1.2
- Devise 3.9.4 via (github: 'heartcombo/devise', branch: 'main')

## Setup and Installation
   All steps necessary to recreate this repo using new rails app name of your choice. Resulting server is fully functional just like this repo. Repo has example commit after each step for user to see step by step changes made.
1. **Create a new Rails application**
   ```bash
   rails new app_name -j esbuild -c bootstrap
   ```
2. **Edit your Gemfile**
   - Make the following changes. Devise using main branch here, could result in newer version, for now this seems to be needed.
   ```ruby
   ruby "3.2.2"
   gem "rails", "~> 7.1.2"
   gem 'devise', github: 'heartcombo/devise', branch: 'main'
   ```
3. **Install Devise Gem**
   ```bash
    bundle install
    ```
4. **Run Devise Generator**
   ```bash
   rails generate devise:install
   ```
5. **Create a User model**
   ```bash
    rails generate devise User
    ```
6. **Edit the devise user model**
   - Add all the devise modules, except :omniauthable
   ```ruby
    app/models/user.rb
    ```
7. **Edit the devise user migration file**
   - Uncomment all the things
   ```ruby
     db/migrate/datetimestamp_devise_create_users.rb
   ```
8. **Create a database and run migrations**
   ```bash
   rails db:drop; rails db:create; rails db:migrate
   ```
9. **Create a pages controller**
    ```bash
     rails generate controller pages home
    ```
10. **Edit the routes file**
    - replace
    ```ruby
    get 'pages/home'
    ```
    - with this code
    ```ruby
     root 'pages#home'
    ```
11. **Edit the development environment file**
      - Add this code to the bottom of the file
    ```ruby
    config.action_mailer.default_url_options = {
      host: "localhost",
      port: 3000
    }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "127.0.0.1",
      port: 1025
    }
    ```
12. **Edit views/layouts/application.html.erb**
    - Add this code to the body, above the yield, (includes bootstrap classes)
    ```html
    <% flash.each do |name, msg| %>
      <% if msg.is_a?(String) %>
        <div class="alert <%= name == 'notice' ? 'alert-success' : 'alert-danger' %>">
          <%= content_tag :div, msg, id: "flash_#{name}" %>
        </div>
      <% end %>
    <% end %>
    ```
13. **Edit app/views/pages/home.html.erb**
    - Add this code to the body, (includes bootstrap classes)
    ```html
     <% if user_signed_in? %>
       <%= link_to "Edit profile", edit_user_registration_path, class: "btn btn-primary" %>
       <%= link_to "Logout", destroy_user_session_path, method: :delete, data: { turbo_method: :delete }, class: "btn btn-danger" %>
     <% else %>
       <%= link_to "Sign up", new_user_registration_path, class: "btn btn-success" %>
       <%= link_to "Login", new_user_session_path, class: "btn btn-secondary" %>
     <% end %>
    ```
14. **Edit initializers/devise.rb**
    - Uncomment the following line
    ```ruby
     config.navigational_formats = ['*/*', :html, :turbo_stream]
    ```
15. **Start your server**
    - Running it first this way, then other ok
    - There is some issue where devise will not use turbo and call DELETE when logging out.
    - Results in this error:
      - No route matches [GET] "/users/sign_out"
    - May need to clear browser cache of cookies also
    ```bash
    rm -rf public/assets; rake assets:clean; rake assets:precompile;  bin/dev
    ```
    - This should work now. All functions of devise and bootstrap should work; sign up, confirm email, sign in, sign out, edit profile, forgot password, etc.
    ```bash
    rails s
    ```
16. **Configure mailcatcher**
    ```bash
    gem install mailcatcher
    ```
17. **Start your mail server**
    ```bash
    mailcatcher
    ```
18. **Open your browser and go to mailcatcher**
    - [localhost:1080](http://localhost:1080/)
19. **Open your browser and go to your app**
    - [localhost:3000](http://localhost:3000/)
## Thank You
- There you have it, a fully functional rails app with devise and bootstrap.
- I hope this helps someone.
- Send me a note to [email](mailto:jh1463@gmail.com)