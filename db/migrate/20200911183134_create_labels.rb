class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name, default: "label_default", null: false
      t.timestamps
    end
  end
end
