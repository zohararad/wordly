class DeviseCreateAuthors < ActiveRecord::Migration
  def up
    create_table :authors, :force => true do |t|
      ## base
      t.column :first_name,   :string,      :null => false, :limit => 255
      t.column :last_name,    :string,      :null => false, :limit => 255
      t.column :email,        :string,      :null => false, :limit => 255
      t.column :website,      :string,      :null => true,  :limit => 255
      t.column :about,        :text,        :null => true
      t.column :meta,         :mediumtext,  :null => true

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token


      t.timestamps
    end

    # Create a default user
    a = Author.new(:first_name => 'admin', :last_name => 'admin', :email => 'admin@example.com')
    a.password = 'password'
    a.password_confirmation = 'password'
    a.save!

    add_index :authors, :email,                :unique => true
    add_index :authors, :reset_password_token, :unique => true
    # add_index :authors, :confirmation_token,   :unique => true
    # add_index :authors, :unlock_token,         :unique => true
    # add_index :authors, :authentication_token, :unique => true
  end

  def down
    drop_table :authors
  end

end
