class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users

  belongs_to :project

  def add_member user
  	users << user
  end

  def remove_member user
  	if users.find_by id: user.id
  		users.delete user
  	end  	
  end
end
