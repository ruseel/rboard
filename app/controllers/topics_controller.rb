class TopicsController < ApplicationController
  helper_method :depth_mark

  before_filter :set_board

  def set_board
    @board = Board.where(id: params[:board_id]).first
  end


  def index
    @topics = @board.topics.page(params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new(topic: @topic)
    @comments = @topic.comments
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.board = @board
    if params[:parent_id].present?
      @topic.parent = Topic.find(params[:parent_id])
    end

    if @topic.save
      redirect_to [@board, @topic], notice: 'Topic was created'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to [@board, @topic], notice: 'Topic was successfuly updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to board_topics_url(@board)
  end

private
  def depth_mark(depth)
    ("&#x21aa;" * depth).html_safe
  end
end
