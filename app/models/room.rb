class Room < ApplicationRecord
  belongs_to :venue
  has_many :courses

end
