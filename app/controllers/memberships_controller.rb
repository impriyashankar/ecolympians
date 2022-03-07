class MembershipsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    param = []
    param = params[:user_id]
    unless param.nil?
      param.each { |id|
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

  def edit
    @membership = Membership.find(params[:id])

  end

  def update_status
    @membership = Membership.find(params[:id])
    new_status = params[:membership][:status]
    @membership.update(status: new_status)
    @membership.save

    if @membership.save
      redirect_to my_dashboard_path(anchor: "pending-member-box" )
    else
      render :edit
    end
  end

  def destroy
    @membership.destroy
    redirect_to group_path(@group, anchor: "pending-member-box")
  end

  private

  def membership_params
    #params.require(:membership).permit(:user_id)
    params.permit(:user_id)
  end

end

#update_status_booking_path(booking, { booking: { status: 'accepted' } } ), method: :patch, remote: true, class: 'btn btn-flat'
#update_status_booking_path(booking, { booking: { status: 'declined' } } ), method: :patch, remote: true, data: { confirm: "Are you sure?" }, class: 'btn btn-gradient'
