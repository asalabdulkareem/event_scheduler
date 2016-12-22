class CreateAvailableTimes < ActiveRecord::Migration
  def change
    create_table :available_times do |t|
      t.references :event, index: true, foreign_key: true
      t.timestamp :from
      t.timestamp :to

      t.timestamps null: false
    end
  end
end
