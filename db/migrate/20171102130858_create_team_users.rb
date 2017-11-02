class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_leader

      t.timestamps
    end
  end
end
