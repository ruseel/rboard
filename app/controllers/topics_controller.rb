class TopicsController < ApplicationController
  helper_method :depth_mark

  def index
    @topics = Topic.all
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
    if params[:parent_id].present?
      @topic.parent = Topic.find(params[:parent_id])
    end

    if @topic.save
      redirect_to @topic, notice: 'Topic was created'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to @topic, notice: 'Topic was successfuly updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to topics_url
  end

private
  def depth_mark(depth)
    ("&#x21aa;" * depth).html_safe
  end
end
