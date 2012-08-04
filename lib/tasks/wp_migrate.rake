desc "Migration tasks of Wordpress Database into Wordly"
namespace :wordly do

  namespace :wordpress do

    desc "Migrate your data from Wordpress to Wordly"
    task :migrate => :environment do
      conn = {:host => 'localhost', :username => 'root', :password => '', :database => 'newsgeekdb', :encoding => 'utf8'}
      print "MySQL Host: "
      conn[:host] = STDIN.gets.chomp
      print "MySQL User: "
      conn[:username] = STDIN.gets.chomp
      print "MySQL Password: "
      conn[:password] = STDIN.gets.chomp
      print "MySQL DB: "
      conn[:database] = STDIN.gets.chomp
      Wordly::WP.migrate_users(conn)
      Wordly::WP.migrate_posts(conn)
      Wordly::WP.migrate_pages(conn)
      Wordly::WP.migrate_categories(conn)
      Wordly::WP.migrate_comments(conn)
      Wordly::WP.migrate_tags(conn)
      puts "\nDone!\n"
    end

  end

end

module Wordly

  class WP

    class << self

      # Migrate Wordpress users
      # @param [Hash] conn MySQL connection settings
      def migrate_users(conn)
        puts "\nMigrating Users"
        ActiveRecord::Base.connection.execute('truncate table authors')
        client = Mysql2::Client.new(conn)
        client.query("select * from wp_users").each(:symbolize_keys => true) do |user|
          next if user[:user_email].nil?
          ar_user = Author.new
          ar_user.email = user[:user_email]
          ar_user.id = user[:ID]
          ar_user.email = user[:user_email]
          ar_user.website = user[:user_url] unless user[:user_url].blank?
          h = { }
          q = "select meta_key, meta_value from wp_usermeta where user_id = %s and meta_key in ('first_name', 'last_name', 'description', 'facebook', 'twitter', 'linkedin')" % user[:ID]
          client.query(q).each(:symbolize_keys => true) do |meta|
            case meta[:meta_key]
              when 'first_name'
                ar_user.first_name = meta[:meta_value]
              when 'last_name'
                ar_user.last_name = meta[:meta_value]
              when 'description'
                ar_user.about = meta[:meta_value]
              else
                h[meta[:meta_key].to_sym] = meta[:meta_value] unless meta[:meta_value].blank?
            end
          end
          ar_user.meta = h.keys.any? ? h : nil
          if ar_user.first_name.nil?
            ar_user.first_name = user[:display_name].split(' ').first
          end
          if ar_user.last_name.nil?
            ar_user.last_name = user[:display_name].split(' ').last
          end
          ar_user.password = user[:user_email]
          if ar_user.save
            print "."
          else
            "Cannot save user with id #{user[:ID]}: %s" % ar_user.errors.messages
          end
        end

      end

      # Migrate Wordpress posts
      # @param [Hash] conn MySQL connection settings
      def migrate_posts(conn)
        puts "\nMigrating posts"
        ActiveRecord::Base.connection.execute('truncate table posts')
        client = Mysql2::Client.new(conn)
        authors = Author.all.collect(&:id)

        client.query("select * from wp_posts where post_status = 'publish' and post_type = 'post' and post_author in (#{authors.join(',')})").each(:symbolize_keys => true) do |wp_post|
          post = Post.new
          post.id = wp_post[:ID]
          post.title = wp_post[:post_title]
          post.slug = wp_post[:post_name]
          post.excerpt = wp_post[:post_excerpt]
          post.content = wp_post[:post_content]
          post.author_id = wp_post[:post_author]
          post.published = true
          post.created_at = wp_post[:post_date]
          post.updated_at = wp_post[:post_modified]
          post.save
          print "."
        end
        client.close
      end

      # Migrate Wordpress pages
      # @param [Hash] conn MySQL connection settings
      def migrate_pages(conn)
        puts "\nMigrating pages"
        ActiveRecord::Base.connection.execute('truncate table pages')
        client = Mysql2::Client.new(conn)
        authors = Author.all.collect(&:id)
        client.query("select * from wp_posts where post_status = 'publish' and post_type = 'page' and post_author in (#{authors.join(',')})").each(:symbolize_keys => true) do |wp_post|
          page = Page.new
          page.id = wp_post[:ID]
          page.title = wp_post[:post_title]
          page.slug = wp_post[:post_name]
          page.content = wp_post[:post_content]
          page.author_id = wp_post[:post_author]
          page.published = true
          page.created_at = wp_post[:post_date]
          page.updated_at = wp_post[:post_modified]
          page.save
          print "."
        end
        client.close
      end

      # Migrate Wordpress categories
      # @param [Hash] conn MySQL connection settings
      def migrate_categories(conn)
        puts "\nMigrating categories"
        ActiveRecord::Base.connection.execute('truncate table categories')
        ActiveRecord::Base.connection.execute('truncate table categories_posts')
        client = Mysql2::Client.new(conn)

        client.query('SELECT wt.term_id, wt.name, wt.slug, wtt.term_taxonomy_id From wp_terms wt INNER JOIN wp_term_taxonomy wtt ON wt.term_id=wtt.term_id WHERE wtt.taxonomy = "category"').each(:symbolize_keys => true) do |wp_category|
          category = Category.new
          category.id = wp_category[:term_id]
          category.name = wp_category[:name]
          category.slug = wp_category[:slug]
          category.save

          client.query('select object_id as post_id from wp_term_relationships where term_taxonomy_id = %s' % wp_category[:term_taxonomy_id]).each(:symbolize_keys => true) do |post|
            ActiveRecord::Base.connection.execute('insert into categories_posts (category_id, post_id) values (%s,%s)' % [category.id, post[:post_id]])
          end
          print "."
        end
        client.close
      end

      # Migrate Wordpress comments
      # @param [Hash] conn MySQL connection settings
      def migrate_comments(conn)
        puts "\nMigrating comments"
        ActiveRecord::Base.connection.execute('truncate table comments')
        client = Mysql2::Client.new(conn)

        client.query("select * from wp_comments where comment_parent = 0 order by comment_post_ID asc").each(:symbolize_keys => true) do |parent_comment|
          begin
            comment = Comment.new
            comment.id = parent_comment[:comment_ID]
            comment.post_id = parent_comment[:comment_post_ID]
            comment.author_id = parent_comment[:user_id]
            comment.author_name = parent_comment[:comment_author].blank? ? '*' : parent_comment[:comment_author]
            comment.author_email = parent_comment[:comment_author_email]
            comment.author_website = parent_comment[:comment_author_url]
            comment.author_ip = parent_comment[:comment_author_IP]
            comment.comment = parent_comment[:comment_content]
            comment.created_at = parent_comment[:comment_date]
            comment.hierarchy = '0'
            comment.save
            print "."
            find_comment_children(comment, client)
          rescue
          end
        end
        client.close
      end

      # Migrate Wordpress tags
      # @param [Hash] conn MySQL connection settings
      def migrate_tags(conn)
        puts "\nMigrating post tags"
        client = Mysql2::Client.new(conn)

        q = "SELECT wt.name, wtr.object_id From wp_terms wt INNER JOIN wp_term_taxonomy wtt ON wt.term_id = wtt.term_id INNER JOIN wp_term_relationships wtr ON wtt.term_taxonomy_id = wtr.term_taxonomy_id WHERE wtt.taxonomy = 'post_tag' ORDER BY object_id asc"
        tags = {}
        client.query(q).each(:symbolize_keys => true) do |post_tag|
          post_id = post_tag[:object_id]
          tags[post_id] ||= []
          tags[post_id] << post_tag[:name]
        end

        tags.each do |post_id, tags|
          begin
            post = Post.find(post_id)
            next if post.nil?
            post.tag_list = tags.join(', ')
            post.save
            print "."
          rescue
          end
        end
        client.close
      end

      # Recursively find child-comments for a given Wordpress comment
      # @param [Mysql2::Result] parent_comment comment to find child comments for
      # @param [Mysql2::Client] client mysql client used to connect to Wordpress DB
      def find_comment_children(parent_comment, client)
        client.query('select * from wp_comments where comment_parent = %s' % parent_comment.id).each(:symbolize_keys => true) do |child_comment|
          comment = Comment.new
          comment.id = child_comment[:comment_ID]
          comment.post_id = child_comment[:comment_post_ID]
          comment.author_id = child_comment[:user_id]
          comment.author_name = child_comment[:comment_author].blank? ? '*' : child_comment[:comment_author]
          comment.author_email = child_comment[:comment_author_email]
          comment.author_website = child_comment[:comment_author_url]
          comment.author_ip = child_comment[:comment_author_IP]
          comment.comment = child_comment[:comment_content]
          comment.created_at = child_comment[:comment_date]
          comment.hierarchy = [parent_comment.hierarchy, parent_comment.id].join('-')

          comment.save
          print "."
          find_comment_children(comment, client)
        end
      end
    end

  end
end