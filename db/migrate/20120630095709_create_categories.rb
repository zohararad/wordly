class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories, :force => true do |t|
      t.column :name, :string, :null => false, :limit => 200
      t.column :slug, :string, :null => false, :limit => 200
    end

    create_table :categories_posts, :id => false, :force => true do |t|
      t.column :category_id, :integer, :null => false, :limit => 20
      t.column :post_id, :integer, :null => false, :limit => 20
    end

    add_index :categories_posts, [:category_id, :post_id], :unique => false
    add_index :categories_posts, [:post_id, :category_id], :unique => false
  end

  def down
    drop_table :categories_posts
    drop_table :categories
  end
end
