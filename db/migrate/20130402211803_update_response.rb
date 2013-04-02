class UpdateResponse < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.integer :question_id
    end
  end
end
