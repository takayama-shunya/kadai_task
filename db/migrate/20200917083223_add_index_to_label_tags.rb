class AddIndexToLabelTags < ActiveRecord::Migration[5.2]
  def change
    add_index :label_tags, :task_id
    add_index :label_tags, :label_id
  end
end
