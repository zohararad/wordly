require 'fileutils'
require 'erb'

desc 'Wordly rake tasks'
namespace :wordly do

  desc 'Theme-related tasks'
  namespace :themes do

    desc 'Create a new Wordly theme under vendor/themes'
    task :create => :environment do
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      themes_dir = Rails.root.join('vendor','themes')
      # Get template name
      while File.directory? File.join(themes_dir,theme_name)
        print "Theme already exists. Please choose a different name: "
        theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      end

      # Variables for ERB templates for javascript and css index files
      theme_templates_dir = Rails.root.join('lib','themes','templates')
      theme_directory = File.join('vendor','themes',theme_name)

      # Generate theme directories and index files
      ['javascripts','stylesheets','images'].each do |d|
        dir = File.join(themes_dir,theme_name, d)
        FileUtils.mkdir_p dir
        FileUtils.touch File.join(dir,'.gitkeep')
        case d
          when 'javascripts'
            template = 'index.js.coffee'
          when 'stylehseets'
            template = 'index.sass'
        end
        # Add asset index file from ERB template
        unless template.nil?
          template_file = File.join(theme_templates_dir,'%s.erb' % template)
          output = ERB.new(File.read(template_file))
          File.open(File.join(dir,template),'w'){|f| f.write(output.result(binding))}
        end
      end
    end

    desc 'Deletes a Wordly theme from vendor/themes'
    task :delete => :environment do
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      theme_dir = Rails.root.join('vendor','themes', theme_name)
      if File.directory? theme_dir
        FileUtils.rm_r theme_dir
      else
        print "Theme not found"
      end
    end

  end

end