class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :status
  belongs_to :level, optional: true

  has_many :label_tasks
  has_many :labels, through: :label_tasks
  has_many :activities
  # enum status: [:new_task, :in_process, :resolved, :testing, :done]

  search = lambda do |keyword|
    where("name LIKE :keyword", keyword: "%#{keyword}%").order id: :desc
  end

  scope :search, search
end
