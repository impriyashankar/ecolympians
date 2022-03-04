class PotentialChallengesController < ApplicationController
  def create
    # potential_challenges = []
    # potential_challenges_ids = params["potential_challenge"]["challenge_id"]
    # potential_challenges_ids.delete_at(0)
    # potential_challenges_ids.each do |id|
    #  po = PotentialChallenge.new(group_id: params[:group_id].to_i, challenge_id: id)
    #  po.save
    #  potential_challenges << po
    # end

    potential_challenges = []
    challenges_names = [ params[:challenge1], params[:challenge2], params[:challenge3] ]
    challenges_names.each do |cn|
      potential_challenges << PotentialChallenge.create!(challenge: Challenge.find_by(name: cn), group_id: params[:group_id].to_i)
    end

    if potential_challenges.last.save
      redirect_to group_path(params[:group_id])
    else
      redirect_to group_path(params[:group_id]), notice: "select failed"
    end
  end

  def new
    @potential_challenge = PotentialChallenge.new
  end

  private

  def potential_challenge_params
    params.require(:potential_challenge).permit(:challenge_id)
  end
end
