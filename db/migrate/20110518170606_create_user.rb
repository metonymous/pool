class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :user do |t|
      t.string :identity_url, :required => true
      t.string :nickname
      t.string :fullname
      t.string :email
      t.string :address
      t.string :url 
      t.string :public_key
      t.belongs_to :account
      t.timestamps
    end
  end

  def self.down
    drop_table :user
  end
end
