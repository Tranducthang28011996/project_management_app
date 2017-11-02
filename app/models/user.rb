class User < ApplicationRecord
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :projects, inverse_of: :owner 
  has_many :comments
  has_many :tasks
end
