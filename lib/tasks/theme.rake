require 'fileutils'
require 'erb'

desc 'Wordly rake tasks'
namespace :wordly do

  desc 'Theme-related tasks'
  namespace :themes do

    desc 'Create a new Wordly theme under vendor/themes'
    task :create => :environment do
      # Get theme name
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      theme_dir = Rails.root.join('vendor','themes', theme_name)

      while File.directory? theme_dir
        print "Theme already exists. Please choose a different name: "
        theme_name = STDIN.gets.chomp.downcase.strip.parameterize
        theme_dir = Rails.root.join('vendor','themes', theme_name)
      end

      # Setup variables for ERB templates used to generate javascript and css index files
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
            template = 'index.css.sass'
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
      theme_name = STDIN.gets.chomp.downcase.parameterize
      theme_dir = Rails.root.join('vendor','themes', theme_name)
      if File.directory? theme_dir
        FileUtils.rm_r theme_dir
      else
        print "Theme not found"
      end
    end

    desc 'Install a theme from vendor/themes into app/assets'
    task :install => :environment do
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      theme_dir = Rails.root.join('vendor','themes', theme_name)

      if File.directory? theme_dir
        assets_dir = Rails.root.join('app','assets')
        css_index = File.join(assets_dir,'stylesheets','theme','index.css.scss')

        # Try to move current theme to vendor/themes
        if File.exists? css_index
          # Find theme name from index.css.scss
          m = File.read(css_index).match(/Wordly\stheme\:\s?([^\n\r]+)/)
          if m.nil?
            print "Could not find current theme name. Please enter a name: "
            old_theme_name = STDIN.gets.chomp.downcase.parameterize
          else
            old_theme_name = m[1].chomp.downcase.parameterize
          end

          # Ensure there is no existing theme with that name under vendor/themes
          old_theme_dir = Rails.root.join('vendor','themes', old_theme_name)
          while File.directory? old_theme_dir
            print "Theme already exists. Please choose a different name: "
            old_theme_name = STDIN.gets.chomp.downcase.strip.parameterize
            old_theme_dir = Rails.root.join('vendor','themes', old_theme_name)
          end

          # Move current theme to vendor/themes
          print "Moving current theme to vendor/themes"
          FileUtils.mkdir_p old_theme_dir
          ['javascripts','stylesheets','images'].each do |d|
            dir = File.join(assets_dir, d)
            if Dir.exists? dir
              FileUtils.move dir, File.join(old_theme_dir,d)
            end
          end
        end

        # Move new theme to app/assets
        ['javascripts','stylesheets','images'].each do |d|
          dir = File.join(theme_dir, d)
          if Dir.exists? dir
            FileUtils.move dir, File.join(assets_dir,d)
          end
        end
        FileUtils.rm_r theme_dir

      end
    end
  end

end