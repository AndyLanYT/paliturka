class Api::V1::ProfilesController < ApplicationController
  def show
    profile = Profile.find_by(user_id: params[:user_id])
    authorize profile, :show?

    render json: profile
  end

  def update
    profile = Profile.find_by(user_id: params[:user_id])
    authorize profile, :update?
    updated_profile = ProfileProcessing::Updater.update!(profile, profile_params)

    render json: updated_profile
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :info, :hidden)
  end
end
