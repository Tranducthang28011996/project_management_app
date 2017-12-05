class Project < ApplicationRecord
  has_many :tasks
  has_one :team
  belongs_to :owner, class_name: User.name, foreign_key: :owner_id
  has_one :statistic

  search = lambda do |keyword|
    where("name LIKE :keyword", keyword: "%#{keyword}%").order id: :desc
  end

  scope :search, search

  scope :load_member_project, (lambda do |user_id|
    joins(team: :users).where "users.id = :user_id AND projects.owner_id <> :user_id",
      user_id: user_id
  end)

  scope :load_project, (lambda do |user_id|
    joins(team: :users).where("users.id = :user_id OR projects.owner_id = :user_id",
          user_id: user_id).distinct
  end)

  def load_activity
    Activity.where(project_id: id).order('created_at DESC')
  end

  def get_member
  	User.where id: (team.users.pluck(:id) + [owner_id])
  end

  def get_leader
    team.team_users.where is_leader: true
  end
end
