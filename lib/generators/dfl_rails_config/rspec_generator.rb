require 'rails/generators'

# TODO: Dividir generator em partes. Ex: DeployGenerator, GemsGenerator, DatabaseGenerator, etc.
module DflRailsConfig
  module Generators
    class RspecGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def rspec_gem
        file_name = 'gemfiles/rspec.rb'
        copy_file file_name.split('/').last, file_name
      end
     
      def rspec_install
        run 'rails generate rspec:install'
      end

      def rspec_always_test_env
        gsub_file 'spec/rails_helper.rb', "ENV['RAILS_ENV'] ||= 'test'", "ENV['RAILS_ENV'] = 'test'"
      end
    end
  end
end
