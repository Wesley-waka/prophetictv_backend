class SermonsController < ApplicationController

    def index
        @sermon = Sermon.all
      end
    
      def new
        @sermon = Sermon.new
      end
    
      def create
        @sermon = Sermon.new(video_params)
        if @sermon.save
          redirect_to videos_path, notice: 'Video uploaded successfully.'
        else
          render :new
        end
      end
  
      def download
          @sermon = Sermon.find(params[:id])
          send_file @sermon.video.path, type: @sermon.video.content_type, disposition: 'attachment'
      end
    
      private
    
      def video_params
        params.require(:video).permit(:title, :description,:video)
      end
end
