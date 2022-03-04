class UsersController < ApplicationController

  def show
    @user = current_user
    @groups = @user.groups
    @group = Group.new
    @group_challenges_ongoing = @user.group_challenges.select{ |challenge| challenge.status == "ongoing"}
    @group_challenges_upcoming = @user.group_challenges.select{ |challenge| challenge.status == "waiting"}
  end
end
