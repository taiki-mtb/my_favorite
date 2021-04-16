class StageArtistsForm
  include ActiveModel::Model
  att_accessor :title, :info, :from_date, :until_date, :place, images: [], :name

  def add_artist
      @artist = Artist.find_or_create_by(artist_params)
  end

  def save
    
  end

  def create
    @stage = Stage.new(stage_params.slice(:title, :info, :from_date, :until_date, :place, images: []))
    if @stage.save
      @artist = Artist.find_or_create_by(name: stage_params[:name])
      @stage.artists << @artist
      flash[:success] = "新しいstageが登録されました"
      redirect_to @stage
    else
      render 'stages/new'
    end
  end
    def artist_params
      params.require(:artist).permit(:name, :info, images: [])
    end
end