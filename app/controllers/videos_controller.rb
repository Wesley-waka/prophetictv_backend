class VideosController < ApplicationController
  skip_before_action :authorized,only: %i[index new create show download]
  
  def index
    @videos = Video.all
    render json: @videos,status: :ok
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path, notice: 'Video uploaded successfully.'
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
    render json: @video,status: :ok
  end

  def download
      @video = Video.find(params[:id])
      send_file @video.video.path, type: @video.video.content_type, disposition: 'attachment'
  end

  private

  def video_params
    params.require(:video).permit(:title, :video,:description,:speaker,:image)
  end
end
