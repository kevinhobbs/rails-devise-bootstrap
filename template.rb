# Ensure copy_file actions have this dir as a source path
source_paths.unshift(File.dirname(__FILE__))

# Add required gems to the Gemfile
gem 'devise', github: 'heartcombo/devise', branch: 'main'

# Run bundle install
run 'bundle install'

# Generate Devise configuration
generate 'devise:install'

# Generate the User model with Devise
generate 'devise user'

# Edit the devise user migration file
migration_file = Dir.glob('db/migrate/*_devise_create_users.rb').first
gsub_file migration_file, /# t./, 't.'
gsub_file migration_file, /# add_index/, 'add_index'

# Edit the User model to include additional devise modules
inject_into_file 'app/models/user.rb', after: "validatable\n" do
  <<-RUBY
         :confirmable, :lockable, :timeoutable, :trackable
  RUBY
end
gsub_file 'app/models/user.rb', /validatable/, 'validatable,'

# Create a database and run migrations
rails_command 'db:create'
rails_command 'db:migrate'

# Create a Pages controller with a home action
generate 'controller Pages home'

# Configure the root route
gsub_file 'config/routes.rb', /get 'pages\/home'/, "root 'pages#home'"

# Configure the development environment for Action Mailer
inject_into_file 'config/environments/development.rb', after: "config.action_controller.raise_on_missing_callback_actions = true\n" do
  <<-RUBY
  \n
  # Configure the default URL for Action Mailer (required for Devise)
  # Make use of the MailCatcher gem to catch and display emails in development
  config.action_mailer.default_url_options = {
    host: "localhost",
    port: 3000
  }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "127.0.0.1",
    port: 1025
  }
  RUBY
end

# Add Flash message display code to application.html.erb
insert_into_file 'app/views/layouts/application.html.erb', before: '<%= yield %>' do
  <<~HTML
    <% flash.each do |name, msg| %>
      <% if msg.is_a?(String) %>
        <div class="alert <%= name == 'notice' ? 'alert-success' : 'alert-danger' %>">
          <%= content_tag :div, msg, id: "flash_\#{name}" %>
        </div>
      <% end %>
    <% end %>
  HTML
end

# Add user authentication links to home.html.erb
insert_into_file 'app/views/pages/home.html.erb', after: '<p>Find me in app/views/pages/home.html.erb</p>' do
  <<~HTML
    <% if user_signed_in? %>
      <%= link_to "Edit profile", edit_user_registration_path, class: "btn btn-primary" %>
      <%= link_to "Logout", destroy_user_session_path, method: :delete, data: { turbo_method: :delete }, class: "btn btn-danger" %>
    <% else %>
      <%= link_to "Sign up", new_user_registration_path, class: "btn btn-success" %>
      <%= link_to "Login", new_user_session_path, class: "btn btn-secondary" %>
    <% end %>
  HTML
end

# Uncomment the navigational_formats line in initializers/devise.rb
uncomment_lines 'config/initializers/devise.rb', /config.navigational_formats/

# Provide instructions and additional steps
say 'Your Rails application with Devise and Bootstrap has been set up.'
say 'You can access your application at http://localhost:3000/'
say 'You can access the MailCatcher interface at http://localhost:1080/'