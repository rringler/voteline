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
  end

  def self.down
    drop_table :votes
  end
end
