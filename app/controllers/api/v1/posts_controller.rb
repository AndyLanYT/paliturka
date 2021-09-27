class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: %i[show update destroy]

  def index
    authorize Post, :index?
    posts = Post.all

    render json: posts
  end

  def show
    authorize @post, :show?
    post = PostProcessing::Finder.find!(@post)

    render json: post
  end

  def create
    authorize Post, :create?
    post = PostProcessing::Creator.create!(post_params, current_user)
    render json: post
  end

  def update
    authorize @post, :update?
    post = PostProcessing::Updater.update!(@post, post_params)
    render json: post
  end

  def destroy
    authorize @post, :destroy?
    PostProcessing::Destroyer.destroy!(@post)
    render json: { id: params[:id], message: 'Successfully destroyed!' }
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end
end
