class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_item(video)
    redirect_to my_queue_path
  end

  private

  def queue_item(video)
    QueueItem.create(video: video, user: current_user, position: new_queue_item_position) unless video_already_in_queue(video)
  end

  def video_already_in_queue(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

end