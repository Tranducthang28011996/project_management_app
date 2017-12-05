class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  after_create :auto_assign_name

  enum role: [:admin, :member]
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :projects, foreign_key: :owner_id
  has_many :comments
  has_many :tasks
  has_many :activities
  has_many :statistics

  def permission_user project
    return :owner if project.owner.id == id
    # return :leader if project.team.team_users.pluck
  end

  private

  def auto_assign_name
    self.name = self.email.split("@").first
    self.role = :member unless self.role
    self.save if self.name
  end
end
