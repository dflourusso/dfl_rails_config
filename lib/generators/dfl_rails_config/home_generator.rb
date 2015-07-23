require 'rails/generators'

module DflRailsConfig
  module Generators
    class HomeGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_navbar
        copy_file 'layouts/_navbar.html.slim', 'app/views/layouts'
      end

      def require_navbar

      end
    end
  end
end
