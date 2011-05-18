class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.identity_url :string, :required => True
      t.nickname :string
      t.fullname :string
      t.email :string
      t.address :string
      t.url :string
      t.public_key :string
      t.belongs_to :account
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
