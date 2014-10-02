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

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    redirect_to my_queue_path
  end

  def update_queue
    params[:queue_items].each do |queue_item_data|
      queue_item = QueueItem.find(queue_item_data[:id])
      queue_item.update_attributes(position: queue_item_data[:position])
    end

    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end

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