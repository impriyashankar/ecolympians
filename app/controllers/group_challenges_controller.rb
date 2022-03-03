class GroupChallengesController < ApplicationController

  def index
    @user = current_user
    #@group_challenge = GroupChallenge.find(params[:group_id])
    @group_challenge = GroupChallenge.where("membership_id = ?",params[:group_id])
    @group = Group.find(params[:group_id])
    #raise
  end

end
