class AddPostUid < ActiveRecord::Migration
  def up
    add_column :posts, :uid, :string, :limit => 16
  end

  def down
    remove_column :posts, :uid
  end
end
