class UsersController < ApplicationController

  def show
    @user = current_user
    @groups = @user.groups
    @group = Group.new
    @group_challenges_ongoing = @user.group_challenges.select{ |challenge| challenge.status == "ongoing" }
    @group_challenges_upcoming = @user.group_challenges.select{ |challenge| challenge.status == "waiting" }
    @group_challenges_finished = @user.group_challenges.select{ |challenge| challenge.status == "finished" }
    @pending_invitations = @user.memberships.where(status: "Pending")
  end

  def update
    if current_user.update(user_params)
      redirect_to my_dashboard_path
    # else
    #   redirect_to my_dashboard_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end
