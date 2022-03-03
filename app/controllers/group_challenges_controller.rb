class GroupChallengesController < ApplicationController
  def show
    @group_challenge = GroupChallenge.find(params[:id])
    @group_challenges = GroupChallenge.where(challenge: @group_challenge.challenge, start_date: @group_challenge.start_date)
  end
end
