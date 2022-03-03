class GroupChallengesController < ApplicationController

  def index
    @user = current_user
    #@group_challenge = GroupChallenge.find(params[:group_id])
    #@group_challenge = GroupChallenge.where("membership_id = ?",params[:group_id]) -- moved to groups_controller
    @group = Group.find(params[:group_id])
    #raise
  end

  def show
    @group_challenge = GroupChallenge.find(params[:id])
    @group_challenges = GroupChallenge.where(challenge: @group_challenge.challenge, start_date: @group_challenge.start_date)
  end
end
