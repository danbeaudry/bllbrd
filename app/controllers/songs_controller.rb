class SongsController < ApplicationController
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.where(slug: params[:id]).first

  	redirect_to songs_path(), notice: 'The page you are looking for does not exist.' and return unless @song

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.where(slug: params[:id]).first
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
      	@song.update_hash()
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.where(slug: params[:id]).first

    respond_to do |format|
      if @song.update_attributes(params[:song])
      	@song.update_hash()
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", notice: params[:message]  }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_links
    @song = Song.where(slug: params[:id]).first
    @song.update_links
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @song, notice: params[:message]  }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.where(slug: params[:id]).first
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end
end
