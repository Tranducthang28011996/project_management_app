class CreateStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.string :title
      t.string :chart_type
      t.integer :width
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
