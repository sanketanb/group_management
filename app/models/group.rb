class Group < ActiveRecord::Base
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users_enrolled, through: :members, source: :user

  validates :name, :description, presence: true
  validates_length_of :name, :minimum => 6
  validates_length_of :description, :minimum => 11
end
