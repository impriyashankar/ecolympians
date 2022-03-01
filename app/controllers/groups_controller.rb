class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @toy.save
      redirect_to groups_path
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
