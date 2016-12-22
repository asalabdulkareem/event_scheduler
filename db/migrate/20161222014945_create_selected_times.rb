class CreateSelectedTimes < ActiveRecord::Migration
  def change
    create_table :selected_times do |t|
      t.references :student, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.timestamp :from
      t.timestamp :to
      t.boolean :suitable

      t.timestamps null: false
    end
  end
end
