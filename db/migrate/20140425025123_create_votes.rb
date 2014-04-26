class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      ## Foreign keys
      t.integer  :user_id, null: false
      t.integer  :poll_id, null: false

      # Polls attributes
      t.string   :value,   null: false

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :poll_id
  end

  def self.down
    drop_table :votes
  end
end
