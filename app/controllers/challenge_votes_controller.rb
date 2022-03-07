class ChallengeVotesController < ApplicationController

  def create
    potential_challenge = PotentialChallenge.find(params[:potential_challenge_id])
    user = current_user
    challenge_vote = ChallengeVote.new(
      potential_challenge: potential_challenge,
      user: user
    )
    challenge_vote.save!
    # redirect_to group_path(potential_challenge.group)
  end
end
