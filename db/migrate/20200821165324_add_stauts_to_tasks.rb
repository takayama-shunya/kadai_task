class AddStautsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, default: "未着手", null: false
  end
end
