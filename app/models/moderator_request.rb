class ModeratorRequest < ApplicationRecord
  belongs_to :course

  enum status: %i[pending accepted rejected]
  after_initialize :set_initial_status, :if => :new_record?

  private

  def set_initial_status
    self.status ||= :pending
  end

end
