require 'fileutils'

desc 'Wordly rake tasks'
namespace :wordly do

  desc 'Theme-related tasks'
  namespace :themes do

    desc 'Create a new Wordly theme under vendor/themes'
    task :create => :environment do
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      themes_dir = Rails.root.join('vendor','themes')
      while File.directory? File.join(themes_dir,theme_name)
        print "Theme already exists. Please choose a different name: "
        theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      end
      ['javascripts','stylesheets','images'].each do |d|
        dir = File.join(themes_dir,theme_name, d)
        FileUtils.mkdir_p dir
        FileUtils.touch File.join(dir,'.gitkeep')
      end
    end

    desc 'Deletes a Wordly theme from vendor/themes'
    task :delete => :environment do
      print "Theme Name: "
      theme_name = STDIN.gets.chomp.downcase.strip.parameterize
      theme_dir = Rails.root.join('vendor','themes', theme_name)
      if !File.directory? theme_dir
        print "Theme not found"
      else
        FileUtils.rm_r theme_dir
      end
    end

  end

end