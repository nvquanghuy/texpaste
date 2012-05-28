class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json
  def index
    redirect_to manage_path
  end

  def manual
    # Nothing here yet
  end

  # GET /manage
  def manage
    #TODO: Check for auth
    @author_notes = Note.where(:user_id => current_user.id)
  end

  # GET /notes/9baob
  # GET /notes/9baob.json
  def show
    @note = Note.find_by_slug(params[:slug])

    if (@note == nil) then
      redirect_to("/", notice: 'There is no note found')
      return
    end


    @author_notes = []
    if (@note.user_id != nil) then
      @author_notes = Note.where(:user_id => @note.user_id)
    end
    
    respond_to do |format|
      format.html {
        render :show
      }
      format.json { render json: @note }
    end
  end


  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/9baob/edit
  def edit
    @note = Note.find_by_slug(params[:slug])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])
    @note.user_id = current_user.id if current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to show_path(@note.slug), notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to show_path(@note.slug), notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to manage_path }
      format.json { head :no_content }
    end
  end
end
