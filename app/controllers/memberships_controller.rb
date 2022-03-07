class MembershipsController < ApplicationController
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

    if @membership.save
      redirect_to group_path(@group, anchor: "member-#{@membership.id}")
    else
      render "groups/show"
    end

    # raise
  #   respond_to do |format|
  #   if @membership.save
  #     format.html {redirect_to group_path(@group), anchor: "member-#{@membership.id}"}
  #     format.json
  #   else
  #     #raise
  #     format.html { render "groups/show" }
  #     format.json
  #   end
  # end

  end

  def update_vote
    @group = Group.find(params[:id])
    @group_challenges = GroupChallenge.where(membership: current_user, group: @group)
    raise
    if @group_challenge.status == "finished"
      @membership.score += @group_challenge.score
    end
  end



  private

  def membership_params
    #params.require(:membership).permit(:user_id)
    params.permit(:user_id)
  end

end
