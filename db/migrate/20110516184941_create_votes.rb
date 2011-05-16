class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string :ip_address
      t.string :direction, :limit => 1
      t.integer :quote_id

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
