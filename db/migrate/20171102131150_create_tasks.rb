class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :creator_id
      t.integer :updator_id
      t.references :status, foreign_key: true
      t.references :level, foreign_key: true
      t.float :estimate_time
      t.float :spent_time
      t.datetime :deadline

      t.timestamps
    end
  end
end
