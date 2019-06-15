class Comment < ApplicationRecord
  belongs_to :publication

  acts_as_votable

end
