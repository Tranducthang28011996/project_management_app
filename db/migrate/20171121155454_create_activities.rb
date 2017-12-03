class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :action_type
      t.integer :source
      t.integer :dest
      t.integer :creator_id
      t.integer :project_id
      t.timestamps
    end
  end
end
