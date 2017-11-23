class AddActionTypeToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :action_type, :integer
  end
end
