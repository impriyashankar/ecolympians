class GroupsController < ApplicationController
  before_action :set_group, only: [ :edit, :update ]
  def index
    #@groups = Group.all
    @user = current_user
    @group_challenge = GroupChallenge.where("membership_id = ?",params[:group_id]) #moved from group_challenges controller
  end

  def show
    @user = current_user
    @group = Group.find(params[:id])
    @group_challenge = GroupChallenge.where("membership_id = ?",params[:id])#moved from group_challenges controller
    #@group_challenge = GroupChallenge.find(params[:id]) #moved from group_challenges controller
    @potential_challenge = PotentialChallenge.new
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
