class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      ## Foreign keys
      t.integer  :user_id,  null: false

      # Polls attributes
      t.string   :question, null: false
      t.datetime :start
      t.datetime :end
      t.integer  :vote_min, null: false
      t.integer  :vote_max, null: false

      t.timestamps
    end

    add_index :polls, :user_id
  end

  def self.down
    drop_table :polls
  end
end
