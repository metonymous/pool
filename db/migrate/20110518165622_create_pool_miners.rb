class CreatePoolMiners < ActiveRecord::Migration
  def self.up
    create_table :pool_miners do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pool_miners
  end
end
