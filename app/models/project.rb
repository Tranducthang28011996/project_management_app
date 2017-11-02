class Project < ApplicationRecord
  belongs_to :owner, class_name: User.name, foreign_key: :owner_id

end
