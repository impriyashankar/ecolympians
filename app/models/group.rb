class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :group_challenges, through: :memberships
  has_many :potential_challenges
  validates :name, presence: true

  def vote_ended?
    return false if potential_challenges.empty?

    DateTime.now - potential_challenges.first.created_at.to_datetime >= 7.days
  end

  def time_left_for_voting

    return false if potential_challenges.empty?

    time = (potential_challenges.first.created_at.to_date + 7.days) - Date.today
    return time.to_i
  end

  def winning_challenge
    potential_challenges.max_by { |cl| cl.challenge_votes.count }
  end

  def voting_check!
    if vote_ended?
      @notification = "Voting has ended! #{winning_challenge.challenge.name} has been selected!"
      potential_challenges.destroy_all
      memberships.each do |membership|
        gc = GroupChallenge.new(start_date: Date.today, status: "ongoing")
        gc.membership = membership
        gc.challenge = winning_challenge.challenge
        gc.save!
      end
    end
  end
end
