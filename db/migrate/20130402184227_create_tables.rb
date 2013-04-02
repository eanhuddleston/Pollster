class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :polls do |t|
      t.string :title
      t.integer :user_id
      t.timestamps
    end

    create_table :questions do |t|
      t.integer :poll_id
      t.string :text
    end

    create_table :responses do |t|
      t.integer :user_id
      t.integer :choice_id
    end

    create_table :choices do |t|
      t.integer :question_id
      t.string :value
    end

  end
end
