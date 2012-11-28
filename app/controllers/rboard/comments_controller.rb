# vim: set fileencoding=utf-8 :
module Rboard
  class CommentsController < ApplicationController

    before_filter :set_board

    def set_board
      @board = Board.where(id: params[:board_id]).first
    end


    def show
      @comment = Comment.find(params[:id])
    end

    def create
      @topic = Topic.find(params[:topic_id])
      @board = @topic.board

      @comment = Comment.new(params[:comment])
      @comment.topic = @topic
      if @topic && @comment.save
        redirect_to [@topic.board, @topic]
      else
        flash[:notice] = "empty body"
        @comments = @topic.comments
        render "rboard/topics/show"
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
end