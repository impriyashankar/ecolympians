class UsersController < ApplicationController

  def show
    @show_rules = true if params[:new_user]
    @user = current_user
    #@groups = @user.groups -- old logic
    @groups = @user.memberships.where(status: "Accepted") # Changed logic to show only 'Accepted' status groups
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
