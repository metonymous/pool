class AddUsersOpenidField < ActiveRecord::Migration
  def self.up
    add_column :users, :openid_identifier, :string
    add_index :users, :openid_identifier
    add_column :users, :login, :string, :default => nil, :null => true
    add_column :users, :crypted_password, :string, :default => nil, :null => true
    add_column :users, :password_salt, :string, :default => nil, :null => true
  end

  def self.down
    remove_column :users, :openid_identifier
    remove_column :users, :login
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
  end
end
