class PotentialChallengesController < ApplicationController

  def create
    @group = Group.find(params[:id])
    if @group.potential_challenges.count == 3
      @group.potential_challenges.destroy_all
    end
    @p_challenge = PotentialChallenge.new(p_challenge_params)
  end

  def votes_tally
    sum = 0
    challenge_votes.each do |challenge_vote|
      if challenge_vote.vote?
        sum -= 1
      else
        sum += 1
      end
    end
    return sum
  end

  private

  def p_challenge_params
    params.require(:potential_challenge).permit(:challenge_id)
  end
end
