class Api::V1::UsersController < ApplicationController
  def following
    user = User.find_by(id: params[:id])
    render json: user.following
  end

  def followers
    user = User.find_by(id: params[:id])
    render json: user.followers
  end
end
