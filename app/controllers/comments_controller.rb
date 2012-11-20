# vim: set fileencoding=utf-8 :
class CommentsController < ApplicationController
  # def index
  #   @comments = Comment.all
  # end

  def show
    @comment = Comment.find(params[:id])
  end

  # def new
  # end

  def create
    @comment = Comment.new(params[:comment])
    @topic = Topic.find(params[:topic_id])
    @comment.topic = @topic
    if @topic && @comment.save
      redirect_to @topic
    else
      render :back, notice: "댓글 작성이 실패했습니다."
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.topic
    else
      render action: "edit"
    end
  end

  def edit

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @comment.topic
  end
end
