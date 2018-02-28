class User < ActiveRecord::Base
  has_secure_password
  has_many :groups
  has_many :members, dependent: :destroy
  has_many :groups_joined, through: :members, source: :group
  
  validates :first_name, :last_name, presence: true

  before_validation :downcase_email
  validates :email, uniqueness: true, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
