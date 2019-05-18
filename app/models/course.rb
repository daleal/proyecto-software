class Course < ApplicationRecord
  # belongs_to :venue
  # has_many :events, dependent: :destroy
  has_many :moderator_requests, dependent: :destroy

end
