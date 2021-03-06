class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  enum role: %i[common administrator]
  after_initialize :set_default_role, :if => :new_record?

  has_and_belongs_to_many :events

  acts_as_voter

  scope :other_than, -> (user_id) do
    where (["(users.id <> ?)",
    user_id])
  end

  private

  def set_default_role
    self.role ||= :common
  end

end
