class MembershipsController < ApplicationController

  def index
    @membership = Membership.new
  end

  def new
    @membership = Membership.new
  end

  def create
    @group = Group.find(params[:group_id])
    @membership = Membership.new(membership_params)
    @membership.group = @group
    if @membership.save
      redirect_to group_path(@group, anchor: "member-#{@membership.id}")
    else
      render "groups/show"
    end
  end

  def show
    @group = Group.find(params[:id])
    @membership = Membership.new
  end

  def membership_params
    params.require(:membership).permit(:user_id)
  end

end
