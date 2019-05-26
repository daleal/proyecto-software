class Event < ApplicationRecord
  # belongs_to :room
  # belongs_to :course
  has_many :publications, dependent: :destroy
  has_and_belongs_to_many :users

end
