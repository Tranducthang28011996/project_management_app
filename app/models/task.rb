class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :status
  belongs_to :level
end
