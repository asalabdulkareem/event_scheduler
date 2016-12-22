class RemoveToFromSelectedTime < ActiveRecord::Migration
  def change
    remove_column :selected_times, :to, :timestamp
  end
end
