class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    #binding.pry
    video = Video.find(params[:video_id])
    queue_item(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    current_user.normalize_queue_item_positions
    redirect_to my_queue_path
  end

  def update_queue
    begin
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |queue_item_data|
          #binding.pry
          queue_item = QueueItem.find(queue_item_data[:id])
          queue_item.update_attributes!(rating: queue_item_data[:rating], position: queue_item_data[:position]) if queue_item.user == current_user
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position numbers"
      redirect_to my_queue_path
      return
    end

    current_user.normalize_queue_item_positions

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