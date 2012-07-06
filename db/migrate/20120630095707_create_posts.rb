class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts, :force => true do |t|
      t.column :title,            :string,    :null => false, :limit => 512
      t.column :slug,             :string,    :null => false, :limit => 200 # wp post_name
      t.column :excerpt,          :text,      :null => false
      t.column :content,          :longtext,  :null => false
      t.column :comment_count,    :integer,   :null => false, :limit => 20, :default => 0
      t.column :author_id,        :integer,   :null => false, :limit => 20
      t.column :published,        :tinyint,   :null => false, :limit => 1, :default => 0
      t.timestamps
    end

    add_index :posts, :author_id, :unique => false
  end

  def down
    drop_table :posts
  end
end
