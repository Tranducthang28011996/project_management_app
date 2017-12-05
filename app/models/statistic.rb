class Statistic < ApplicationRecord
  before_save {chart_type.downcase!}
end
