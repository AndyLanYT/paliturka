class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find(params[:id])

    render json: post
  end

  def create
    post = current_user.posts.new(post_params)

    if post.save
      render json: { status: 'Successfully created!' }
    else
      render json: { error: 'Not saved!' }
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)

    render json: post
  end

  def destroy
    post = Post.find(params[:id])

    if post
      post.destroy
      render json: { status: 'Successfully destroyed!' }
    else
      render json: { error: 'Post not found!' }, status: :not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
