class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(id: params[:followed_id])
    current_user.follow(user)

    render json: { status: 'Successfuly followed!' }
  end

  def destroy
    user = User.find_by(id: params[:user_id])
    current_user.unfollow(user)

    render json: { status: 'Successfuly unfollowed!' }
  end
end
