class Course < ApplicationRecord
  # belongs_to :venue
  has_many :events, dependent: :destroy

end
