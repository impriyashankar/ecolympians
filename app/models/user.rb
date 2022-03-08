class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :group_challenges, through: :memberships
  has_one_attached :photo

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def score
    total_score = 0
    memberships.each do |membership|
      total_score += membership.score
    end
    return total_score
  end

  def update_challenge_status!
    group_challenges.select { |challenge| challenge.status == "ongoing" && Date.today > (challenge.start_date + 14) }.each do |group_challenge|
      group_challenge.status = "finished"
      if group_challenge.proof_votes.select{ |proofvote| proofvote.vote == true }.count >= group_challenge.proof_votes.select{ |proofvote| proofvote.vote == false}.count
        group_challenge.membership.score += group_challenge.challenge.score
      end
    end
  end
end
