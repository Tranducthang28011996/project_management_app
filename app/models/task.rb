class Task < ApplicationRecord
  after_create :activity_create
  after_update :activity_update
  after_update_commit {TaskBroadcastJob.perform_later self}

  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :status
  belongs_to :level, optional: true

  has_many :label_tasks
  has_many :labels, through: :label_tasks
  has_many :activities

  search = lambda do |keyword|
    where("name LIKE :keyword", keyword: "%#{keyword}%").order id: :desc
  end

  scope :search, search

  private

  def activity_create
    if User.find_by id: creator_id
      self.activities.create user_id: creator_id, action_type: :add_task,
        creator_id: creator_id, project_id: self.project.id,
        source: status_id
    end
  end

  def activity_update
    user = User.find_by id: updator_id
    if user
      if saved_change_to_attribute? :status_id
        self.activities.create user_id: updator_id, action_type: :move_task,
          source: saved_change_to_attribute(:status_id)[0],
          dest: saved_change_to_attribute(:status_id)[1],
          creator_id: creator_id, project_id: self.project.id
      end

      if saved_change_to_attribute? :user_id
        self.activities.create user_id: user_id, action_type: :assign_member,
          creator_id: updator_id, project_id: self.project.id

        self.activities.create user_id: saved_change_to_attribute(:user_id)[0], action_type: :move_member,
          creator_id: updator_id, project_id: self.project.id if saved_change_to_attribute(:user_id)[0]

      end
    end
  end
end
