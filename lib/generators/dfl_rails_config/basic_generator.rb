require 'rails/generators'

module DflRailsConfig
  module Generators
    class BasicGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
     
      def create_version_file
         create_file "lib/version.rb", <<-FILE
    module #{application_name}
      VERSION = '0.0.1'
    end
        FILE
      end

      def copy_deploy_files
        directory 'bin/', 'bin/deploy/*'
      end

      def replace_deploy_vars
        f = 'bin/_heroku_vars.sh'
        gsub_file f, '_STAGING_APP', "#{application_name.underscore}_staging"
        gsub_file f, '_STAGING_NAME', "'#{application_name.underscore.humanize} Staging'"
        gsub_file f, '_PRODUCTION_APP', application_name.underscore
        gsub_file f, '_PRODUCTION_NAME', "'#{application_name.underscore.humanize}'"
        gsub_file f, '_APP_DOMAIN', "#{application_name.underscore}.com.br"
      end

      def add_flash_types
        file_name = 'app/controllers/application_controller.rb'
        unless File.read(file_name) =~ /add_flash_types/
          inject_into_file file_name, after: 'protect_from_forgery with: :exception' do
            "\n  add_flash_types :warning, :error, :info"
          end
        end
      end

      def inject_default_date_formats
        file_name = 'config/application.rb'
        unless File.read(file_name) =~ /Date::DATE_FORMATS/
          inject_into_file file_name, after: "raise_in_transactional_callbacks = true" do
            "\n    Date::DATE_FORMATS[:default] = '%d/%m/%Y'"
          end
        end
        unless File.read(file_name) =~ /Time::DATE_FORMATS/
          inject_into_file file_name, after: "raise_in_transactional_callbacks = true" do
            "\n    Time::DATE_FORMATS[:default] = '%d/%m/%Y %H:%M:%S'"
          end
        end
      end
      
      def rubocop_config
        file_name = '.rubocop.yml'
        copy_file file_name, file_name
      end

      def gem_font_awesome_rails
        append_file 'Gemfile', "\ngem 'font-awesome-rails'" unless File.read('Gemfile') =~ /font-awesome-rails/
      end

      def gem_better_errors
        unless File.read('Gemfile') =~ /better_errors/
          inject_into_file 'Gemfile', after: "group :development, :test do" do
            "\n  gem 'better_errors'\n"
          end
        end
      end

      def gem_ruby_version
        unless File.read('Gemfile') =~ /ruby /
          inject_into_file 'Gemfile', after: "source 'https://rubygems.org'\n" do
            "\nruby '2.2.2'"
          end
        end
      end

      def include_gems_directory
        string_to_append = "\nDir.glob('gemfiles/**/*.rb') { |f| eval_gemfile f }\n"
        regex = /Dir.glob\('gemfiles\/\*\*\/\*.rb'\)/
        directory 'gemfiles/', 'gemfiles/basic'
        append_file 'Gemfile', string_to_append unless File.read('Gemfile') =~ regex
        Bundler.with_clean_env {run "bundle install --without production"}
      end

      def overcommit_install
        # run 'overcommit --install'
        file_name = '.overcommit.yml'
        remove_file file_name
        copy_file file_name, file_name
      end

      # def rspec_install
      #   run 'rails generate rspec:install'
      # end

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

      # def rspec_always_test_env
      #   gsub_file 'spec/rails_helper.rb', "ENV['RAILS_ENV'] ||= 'test'", "ENV['RAILS_ENV'] = 'test'"
      # end

      def i18n_pt_br
        file_name = 'config/application.rb'
        gsub_file file_name, '# config.i18n.default_locale = :de', "config.i18n.default_locale = :'pt-BR'"
      end

      def ransak_simple_form
        file_name = 'config/application.rb'
        unless File.read(file_name) =~ /RANSACK_FORM_BUILDER/
          inject_into_file file_name, before: "require 'rails/all'" do
            "ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'\n"
          end
        end
      end

      def configure_database
        file_name = 'config/database.yml'
        remove_file file_name
        copy_file file_name.split('/').last, file_name
        gsub_file file_name, 'database_name', application_name.underscore
        gsub_file file_name, 'database_name_test', "#{application_name.underscore}_test"
      end

      def application_js
        file_name = 'app/assets/javascripts/application.js'
        remove_file file_name
        copy_file file_name.split('/').last, file_name
      end

      def application_css
        rm_file_name = 'app/assets/stylesheets/application.css'
        file_name = 'app/assets/stylesheets/application.css.scss'
        remove_file rm_file_name
        copy_file file_name.split('/').last, file_name
      end

      protected

      def application_name
        Rails.application.class.parent_name
      end
    end
  end
end
