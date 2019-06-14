class Publication < ApplicationRecord
  belongs_to :course
  has_many :comments, dependent: :destroy

  acts_as_votable

end
