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

  def update
    @group_challenge = GroupChallenge.find(params[:id])
    @group = @group_challenge.membership.group
    if params[:group_challenge][:photo].present?
      @group_challenge.update(group_challenge_params)
      redirect_to group_group_challenge_path(@group, params[:id])
    else
      redirect_to group_path(@group), notice: "No photo provided!"
    end
  end

  private

  def group_challenge_params
    params.require(:group_challenge).permit(:comment, :photo)
  end
end
