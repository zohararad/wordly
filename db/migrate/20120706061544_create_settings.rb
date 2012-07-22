class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings, :force => true do |t|
      t.column :configuration, :longtext, :null => false
    end

    Setting.create! :configuration => Setting::DEFAULT_SETTINGS
  end

  def down
    drop_table :settings
  end
end
