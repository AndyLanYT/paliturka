class Api::V1::CommentsController < ApplicationController
  before_action :find_comment, only: %i[show update destroy]

  def index
    authorize Comment, :index?
    comments = Comment.all

    render json: comments
  end

  def show
    authorize @comment, :show?
    comment = CommentProcessing::Finder.find!(@comment)
    render json: comment
  end

  def create
    post = Post.find_by(id: params[:post_id])
    authorize Comment, :create?
    comment = CommentProcessing::Creator.create!(comment_params, current_user, post)
    render json: comment
  end

  def update
    authorize @comment, :update?
    comment = CommentProcessing::Updater.update!(@comment, comment_params)
    render json: comment
  end

  def destroy
    authorize @comment, :destroy?
    CommentProcessing::Destroyer.destroy!(@comment)
    render json: { id: params[:id], message: 'Successfuly destroyed!' }
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
