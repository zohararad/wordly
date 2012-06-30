class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments, :force => true do |t|
      t.column :post_id,          :integer,   :null => false, :limit => 20
      t.column :author_id,        :integer,   :null => true,  :limit => 20
      t.column :author_name,      :string,    :null => false, :limit => 100
      t.column :author_email,     :string,    :null => true,  :limit => 60
      t.column :author_website,   :string,    :null => true,  :limit => 100
      t.column :author_ip,        :string,    :null => false, :limit => 100
      t.column :comment,          :text,      :null => false
      t.column :hierarchy,        :string,    :null => false, :limit => 2048, :default => '0'
      t.timestamps
    end

    add_index :comments, :post_id, :unique => false
    add_index :comments, :author_id, :unique => false
  end

  def down
    drop_table :comments
  end
end