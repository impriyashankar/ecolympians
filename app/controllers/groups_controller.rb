class GroupsController < ApplicationController
  before_action :set_group, only: [ :edit, :update ]
  def index
    #@groups = Group.all
    @user = current_user
    @groups = @user.memberships.where(status: "Accepted") # change to show only member groups
    @user = current_user
    #raise
    @other_groups = Group.where.not(id:Membership.where(user: @current_user).distinct.pluck(:group_id)) # selecting other groups available
  end

  def show
    @user = current_user
    @users = User.all
    @group = Group.find(params[:id])
    @potential_challenge = PotentialChallenge.new
    @current_membership = Membership.where(user: @user, group: @group, status: "Accepted")
    @membership = Membership.new
    @group_challenges_ongoing = GroupChallenge.where(membership: @current_membership, status: "ongoing")
    @group_challenges_upcoming = GroupChallenge.where(membership: @current_membership, status: "waiting")
    @group_challenges_finished = GroupChallenge.where(membership: @current_membership, status: "finished")
    @group_challenges = GroupChallenge.where(membership: @current_membership) # moved from group_challenges controller
    @user_role = Membership.where(user: current_user, group: @group).first.role
    @user_voted = false
    @group.potential_challenges.each do |potential_challenge|
      @user_voted = true if ChallengeVote.exists?(user: current_user, potential_challenge: potential_challenge)
    end
  end

  def new
    @group = Group.new
  end

  def create
    @user = current_user
    @group = Group.new(group_params)
    if @group.save
      @membership = Membership.new(role: "Admin", status: "Accepted")
      @membership.group = @group
      @membership.user = @user
      @membership.save

      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @group.update(group_params)

    redirect_to groups_path
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
