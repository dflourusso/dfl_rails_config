require 'rails/generators'

# TODO: Dividir generator em partes. Ex: DeployGenerator, GemsGenerator, DatabaseGenerator, etc.
module DflRailsConfig
  module Generators
    class GemsGeneratorsGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

       def overcommit_install
        # run 'overcommit --install'
        file_name = '.overcommit.yml'
        remove_file file_name
        copy_file file_name, file_name
      end

      def devise_install
        run 'rails generate devise:install'

        #password length
        old_config = 'config.password_length = 8..72'
        new_config = 'config.password_length = Rails.env.production? ? 8..72 : 1..8'
        gsub_file 'config/initializers/devise.rb', old_config, new_config
      end

      def kaminari_views
        run 'rails g kaminari:views bootstrap3'
      end

      def simple_form_install
        run 'rails generate simple_form:install --bootstrap'  
      end

      def rspec_gem
        file_name = 'gemfiles/rspec.rb'
        copy_file file_name, file_name
        Bundler.with_clean_env {run "bundle install --without production"}
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
