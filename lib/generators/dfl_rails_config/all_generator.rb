require 'rails/generators'

module DflRailsConfig
  module Generators
    class AllGenerator < Rails::Generators::Base
      desc "Install DflRailsConfig"
      def generator
        # Load all generators in load path
        # https://github.com/rails/rails/blob/master/railties/lib/rails/generators.rb#L291-L303
        Rails::Generators.lookup!
        DflRailsConfig::Generators.constants.sort().each do |const|
          puts const
          generator_class = DflRailsConfig::Generators.const_get(const)
          next if self.class == generator_class
          if generator_class <=> Rails::Generators::Base
            namespace = generator_klass_to_namespace(generator_class)
            puts "#{namespace}"
            invoke(namespace)
          end
        end
      end
      private
      def generator_klass_to_namespace(klass)
        namespace = Thor::Util.namespace_from_thor_class(klass)
        return namespace.sub(/_generator$/, '').sub(/:generators:/, ':')
      end 
    end
  end
end
