class ProofVotesController < ApplicationController

  def create
    group_challenge = GroupChallenge.find(params[:group_challenge_id])
    user = current_user
    vote = params[:vote] == "true"
    proof_vote = ProofVote.new(
      group_challenge: group_challenge,
      user: user,
      vote: vote
    )

    proof_vote.save!
    # redirect_to group_group_challenge_path(group_challenge.membership.group, group_challenge)
  end
end
