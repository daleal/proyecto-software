class Venue < ApplicationRecord
  has_many :rooms, dependent: :destroy

end
