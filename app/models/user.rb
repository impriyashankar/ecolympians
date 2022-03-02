class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  has_many :groups, through: :memberships
  has_many :memberships
  has_one_attached :photo

  def full_name
    "#{first_name} #{last_name}"
  end

  def score
    total_score = 0
    memberships.each do |membership|
      total_score += membership.score
    end
    return total_score
  end
end
