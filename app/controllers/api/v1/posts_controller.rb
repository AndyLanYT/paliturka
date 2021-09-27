class Api::V1::PostsController < ApplicationController
  def index
    authorize Post, :index?
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find(params[:id])

    if post
      authorize post, :show?
      render json: post
    else
      render json: { status: :not_found }
    end
  end

  def create
    authorize Post, :create?
    post = current_user.posts.new(post_params)

    if post.save
      render json: { status: 'Successfully created!' }
    else
      render json: { error: 'Not saved!' }
    end
  end

  def update
    post = Post.find(params[:id])

    if post
      authorize post, :update?
      post.update(post_params)

      render json: post
    else
      render json: {}, status: :not_found
    end
  end

  def destroy
    post = Post.find(params[:id])

    if post
      authorize post, :destroy?
      post.destroy
      render json: { status: 'Successfully destroyed!' }
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
