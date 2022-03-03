class PotentialChallengesController < ApplicationController

  def create
    @p_challenge = PotentialChallenge.new(p_challenge_params)
    @p_challenge.group = Group.find(params[:id])

  end

  private

  def p_challenge_params
    params.require(:potential_challenge).permit(:challenge_id)
  end
end
