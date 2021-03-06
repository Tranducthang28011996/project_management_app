class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :projects, inverse_of: :owner 
  has_many :comments
  has_many :tasks
end
