class Event < ApplicationRecord
  belongs_to :room
  belongs_to :course
  # has_many :publications, dependent: :destroy
end
