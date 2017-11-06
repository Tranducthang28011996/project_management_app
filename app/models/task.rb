class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :status
  belongs_to :level, optional: true

  # enum status: [:new_task, :in_process, :resolved, :testing, :done]
end
