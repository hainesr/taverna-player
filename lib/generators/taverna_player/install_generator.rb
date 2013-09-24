
module TavernaPlayer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Taverna Player initializer"

      def copy_initializer
        copy_file "initializer.rb",
          "config/initializers/taverna_player.rb.example"
      end

      def show_readme
        readme "ReadMe.txt" if behavior == :invoke
      end
    end
  end
end
