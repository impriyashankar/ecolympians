class GroupsController < ApplicationController
  before_action :set_group, only: [ :edit, :update ]
  def index
    @groups = Group.all
    @user = current_user
  end

  def show
    @user = current_user
    @users = User.all
    @group = Group.find(params[:id])
    @potential_challenge = PotentialChallenge.new
    @membership = Membership.where(user: @user, group: @group, status: "Accepted")
    @group_challenges = GroupChallenge.where(membership: @membership) # moved from group_challenges controller
    # @group_challenge = GroupChallenge.find(params[:id]) #moved from group_challenges controller

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
