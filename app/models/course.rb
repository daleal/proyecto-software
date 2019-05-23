class Course < ApplicationRecord
  has_many :moderator_requests, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :publications, dependent: :destroy
  belongs_to :room

end
