class ChallengesController < ApplicationController
  # before_action :set_challenge, only: [ :edit, :update ]
  def index
    @challenges = Challenge.all
    if params[:query].present?
      @challenges = Challenge.search_by_score_category_name(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'challenges/list', locals: { challenges: @challenges }, formats: [:html] }
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to challenges_path
    else
      render :new
    end
  end

  # def update
  #   @challenge.update(challenge_params)

  #   redirect_to challenges_path
  # end

  # def destroy
  # end

  private

  def group_params
    params.require(:challenge).permit(:name, :description, :category)
  end

  def set_group
    @challenge = Challenge.find(params[:id])
  end
end
