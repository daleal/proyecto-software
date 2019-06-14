class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  enum role: %i[common administrator]
  after_initialize :set_default_role, :if => :new_record?

  private

  def set_default_role
    self.role ||= :common
  end

  acts_as_voter

end
