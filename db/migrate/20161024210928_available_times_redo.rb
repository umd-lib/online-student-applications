class AvailableTimesRedo < ActiveRecord::Migration[4.2]
  def change

    add_column :available_times, :day, :integer, default: 0, null: false
    add_column :available_times, :time, :integer, default: 0, null: false

    remove_column :available_times,  :start
    remove_column :available_times,  :end
    remove_column :available_times, :all_day

    drop_table :available_days
  end
end
