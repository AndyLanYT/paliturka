class ProfilesController < ApplicationController
  def index
    authorize Profile, :index?
    profiles = Profiles.all
    render json: profiles
  end

  def show
    profile = Profile.find_by(id: params[:id])
    authorize profile, :show?
    render json: profile
  end

  def update
    profile = Profile.find_by(id: params[:id])

    if profile
      authorize profile, :update?
      profile.update(profile_params)
      render json: profile
    else
      render json: { status: 'Profile not found!!' }, status: :not_found
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :info)
  end
end
