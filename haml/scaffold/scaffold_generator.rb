 require 'generators/haml'
 require 'rails/generators/erb/scaffold/scaffold_generator'
 require 'rails/generators/erb'
        


module Haml
  module Generators
    module Base 
      protected
      def format
        :html
      end
      
      def handler
        :haml
      end

      def filename_with_extensions(name)
        [name,format,handler].compact.join(".")
      end
    end

    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      extend TemplatePath
      include Base

      def copy_layout_file
        return unless options[:layout]
        template "layout.haml.erb",
                 File.join("app/views/layouts", controller_class_path, "#{controller_file_name}.haml")
      end

      def copy_view_files
        views = available_views
        views.delete("index") if options[:singleton]
        views.each do |view|
          filename = filename_with_extensions(view)
          template filename, File.join("app/views", controller_file_path, filename)
        end
      end

      protected

        def copy_view(view)
          template "#{view}.haml.erb", File.join("app/views", controller_file_path, "#{view}.haml")
        end

    end
  end
end
