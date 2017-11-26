class Project < ApplicationRecord
  has_many :tasks
  has_one :team
  belongs_to :owner, class_name: User.name, foreign_key: :owner_id

  search = lambda do |keyword|
    where("name LIKE :keyword", keyword: "%#{keyword}%").order id: :desc
  end

  scope :search, search

  # scope :get_leader, (lambda do
  #   team.team_users.where is_leader: true
  # end)

  def get_member
  	User.where id: (team.users.pluck(:id) + [owner_id])
  end

  def get_leader
    team.team_users.where is_leader: true
  end
end
