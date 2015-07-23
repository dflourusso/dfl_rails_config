require 'rails/generators'

module DflRailsConfig
  module Generators
    class HomeGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      
      def create_welcome_controller
        run 'rails generate controller welcome --no-helper --no-assets'
      end
      def create_welcome_index
        create_file "app/views/welcome/index.html.slim", <<-FILE
          h1 Welcome
        FILE
      end

      def change_root_path
        gsub_file 'config/routes.rb', "# root 'welcome#index'", "root 'welcome#index'"
      end

      def copy_navbar
        copy_file 'layouts/_navbar.html.slim', 'app/views/layouts/_navbar.html.slim'
      end

      def require_navbar
        unless File.read('Gemfile') =~ /layouts\/navbar/
          inject_into_file 'app/views/layouts/application.html.erb', before: "<%= yield %>" do
            "<%= render 'layouts/navbar' %>\n"
          end
        end
      end
    end
  end
end
