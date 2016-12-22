class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :lecture_title
      t.text :description
      t.string :email
      t.integer :num_times
      t.decimal :duration
      t.string :link1
      t.string :link2

      t.timestamps null: false
    end
  end
end
