class AddExpiredToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired, :date, default: -> { 'NOW()' }, null: false
  end
end
