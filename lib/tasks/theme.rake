require 'fileutils'

desc 'Wordly rake tasks'
namespace :wordly do

  desc 'Theme-related tasks'
  namespace :theme do

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

      theme_templates_dir = Rails.root.join('lib','themes','template')

      FileUtils.mkdir_p theme_dir
      ['views','assets'].each do |dir|
        src = File.join(theme_templates_dir,dir)
        dest = File.join(theme_dir,dir)
        FileUtils.cp_r src, dest
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

  end

end