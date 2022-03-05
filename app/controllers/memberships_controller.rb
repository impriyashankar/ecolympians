class MembershipsController < ApplicationController

  # def index
  #   @membership = Membership.new
  # end

  # def new
  #   @membership = Membership.new
  # end

  def create
    @group = Group.find(params[:group_id])
    param = []
    param = params[:user_id]
    unless param.nil?
      param.each{|id|
        id = id.to_i
        @membership = Membership.new(role: 'Member', status: 'Pending', user_id: id)
        @membership.group = @group
        @membership.role = 'Member'
        @membership.status = 'Pending'
        @membership.save
      }
    else
      render "groups/show"
    end

      # redirect_to group_path(@group, anchor: "member-#{@membership.id}")
      # raise
      # if @membership.save
      #   redirect_to group_path(@group, anchor: "member-#{@membership.id}")
      # else
      #   raise
      #   render "groups/show"
      # end


    # @membership = Membership.new(user_id: params[:user_id])
    # @membership.role = 'Member'
    # @membership.status = 'Pending'
    # @membership.group = @group

    # raise
    if @membership.save
      redirect_to group_path(@group, anchor: "member-#{@membership.id}")
    else
      raise
      render "groups/show"
    end
    #@membership = Membership.new(membership_params)

  end

  # def show
  #   @group = Group.find(params[:id])
  #   @membership = Membership.new
  # end

  private

  def membership_params
    #params.require(:membership).permit(:user_id)
    params.permit(:user_id)
  end

end
