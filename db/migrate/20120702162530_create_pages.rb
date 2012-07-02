class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.column :page_title,       :string,    :null => false, :limit => 512
      t.column :slug,             :string,    :null => false, :limit => 200
      t.column :page_content,     :longtext,  :null => false
      t.column :author_id,        :integer,   :null => false, :limit => 20
      t.column :published,        :tinyint,   :null => false, :limit => 1, :default => 0
      t.timestamps
    end

    add_index :pages, :author_id, :unique => false
  end

  def down
    drop_table :pages
  end
end
