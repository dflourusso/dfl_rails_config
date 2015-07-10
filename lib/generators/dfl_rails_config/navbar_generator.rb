require 'rails/generators'

module DflRailsConfig
  module Generators
    class NavbarGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      
      def teste
        puts 'Adicionar codigo para criar navbar'
      end
    end
  end
end
