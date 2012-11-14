class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to @topic, notice: 'Topic was created'
    end
  end

  def edit
  end

  def destroy
  end
end
