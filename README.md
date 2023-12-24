# Project Name
Rails-Devise-Bootstrap

## Overview
Create rails app with devise and bootstrap

## System Requirements
- Ruby 3.2.2
- Rails 7.1.2
- Devise 3.9.4 via (github: 'heartcombo/devise', branch: 'main')

## Setup and Installation
   All steps necessary to recreate this repo using new rails app name of your choice. Resulting server is fully functional just like this repo.
1. **Create a new Rails application**
   ```bash
   rails new app_name -j esbuild -c bootstrap
   ```
3. **Edit your Gemfile**
   - Make the following changes
   ```ruby
   ruby "3.2.2"
   gem "rails", "~> 7.1.2"
   gem 'devise', github: 'heartcombo/devise', branch: 'main'
   ```
4. **Install Devise Gem**
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
   - Add all the devise modules
   ```ruby
    app/models/user.rb
    ```
6. **Edit the devise user migration file**
   - Uncomment all the things
   ```ruby
     db/migrate/_devise_create_users.rb
   ```
6. **Create a database and run migrations**
   ```bash
    rails db:create
    rails db:migrate
    ```
6. **Create a pages controller**
    ```bash
     rails generate controller pages home
    ```
7. **Edit the routes file**
    ```ruby
     root 'pages#home'
    ```
8. **Edit the development environment file**
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
8. **Edit views/layouts/application.html.erb**
   - Add this code to the body, above the yield, with bootstrap classes
   ```html
   <% flash.each do |name, msg| %>
     <% if msg.is_a?(String) %>
       <div class="alert <%= name == 'notice' ? 'alert-success' : 'alert-danger' %>">
         <%= content_tag :div, msg, id: "flash_#{name}" %>
       </div>
     <% end %>
   <% end %>
   ```
9. **Edit app/views/pages/home.html.erb**
   - Add this code to the body, with bootstrap classes
   ```html
    <% if user_signed_in? %>
      <%= link_to "Edit profile", edit_user_registration_path, class: "btn btn-primary" %>
      <%= link_to "Logout", destroy_user_session_path, method: :delete, data: { turbo_method: :delete }, class: "btn btn-danger" %>
    <% else %>
      <%= link_to "Sign up", new_user_registration_path, class: "btn btn-success" %>
      <%= link_to "Login", new_user_session_path, class: "btn btn-secondary" %>
    <% end %>
   ```
12. **Edit initializers/devise.rb**
    - Uncomment the following line
    ```ruby
     config.navigational_formats = ['*/*', :html, :turbo_stream]
    ```
13. **Start your server**
    ```bash
    rails s
    ```
14. **Configure mailcatcher**
    ```bash
    gem install mailcatcher
    ```
14. **Start your mail server**
    ```bash
    mailcatcher
    ```
15. **Open your browser and go to mailcatcher**
    ```bash
    http://localhost:1080/
    ```
16. **Open your browser and go to your app**
    ```bash
    http://localhost:3000/
    ```
