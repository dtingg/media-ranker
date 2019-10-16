class AddCreatedToVote < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :created, :date
  end
end
