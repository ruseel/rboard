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
    @topic = Topic.find(params[:topic_id])

    @comment = Comment.new(params[:comment])
    @comment.topic = @topic
    if @topic && @comment.save
      redirect_to [@board, @topic]
    else
      flash[:notice] = "empty body"
      @comments = @topic.comments
      render "topics/show"
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
