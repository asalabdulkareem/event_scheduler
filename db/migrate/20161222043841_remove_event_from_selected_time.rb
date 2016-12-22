class RemoveEventFromSelectedTime < ActiveRecord::Migration
  def change
    remove_column :selected_times, :event_id, :integer
  end
end
