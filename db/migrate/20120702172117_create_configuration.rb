class CreateConfiguration < ActiveRecord::Migration
  def up
    create_table :configuration, :force => true, :id => false do |t|
      t.column :settings, :mediumtext, :null => false
    end

    Configuration.create! :settings => {:site_name => '', :theme => 'default'}
  end

  def down
    drop_table :configuration
  end
end
