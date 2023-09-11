class VideoDownloadsController < ApplicationController
    skip_before_action :authorized,only: %i[index new create show download]
    
    def index
      @videos = VideoDownload.all
      render json: @videos,status: :ok
    end
  
    def new
      @video = VideoDownload.new
    end
  
    def create
      @video = Videodownload.new(video_params)
      if @video.save
        redirect_to videos_path, notice: 'Video uploaded successfully.'
      else
        render :new
      end
    end
  
    def show
      @video = VideoDownload.find(params[:id])
      render json: @video,status: :ok
    end
  
    def download
        @video = VideoDownload.find(params[:id])
        send_file @video.video.path, type: @video.video.content_type, disposition: 'attachment'
    end
  
    private
  
    def video_params
      params.permit(:title,:description,:speaker,:image,:downloaded)
    end
  end
  