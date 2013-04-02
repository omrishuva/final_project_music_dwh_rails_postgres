class AttributesController < ApplicationController


  def index
    @tables = Table.all.map(&:name)
    
    if params[:table]
    	table_id = Table.find_by_name params[:table]
    	@attributes = Attribute.where(table_id: table_id)
    end	

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])

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
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def dashboard
  	attributes = Attribute.where(id: params["selected"].keys )
  	category = AttributeCategory.find_by_name( params["category"] ) || AttributeCategory.create( name: params["category"] )
  	AttributeCategoryRelation.build_relation( attributes, category.id )
  	redirect_to attributes_path
  end	
  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @attribute = Attribute.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

end
