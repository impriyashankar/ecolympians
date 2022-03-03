class UsersController < ApplicationController

  def show
    @user = current_user
    @groups = @user.groups
    @group = Group.new
    @group_challenges = @user.group_challenges
  end
end
