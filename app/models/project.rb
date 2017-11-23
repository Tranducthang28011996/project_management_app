class Project < ApplicationRecord
  has_many :tasks
  has_one :team
  belongs_to :owner, class_name: User.name, foreign_key: :owner_id

  def get_member
  	User.where id: (team.users.pluck(:id) + [owner_id])
  end
end
