class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @groups = @user.groups
    @group = Group.new
    @challenges = @user.group_challenges

    respond_to do |format|
      format.html
      format.text { render partial: 'groups/my_groups', locals: { groups: @groups }, formats: [:html] }
    end
  end
end
