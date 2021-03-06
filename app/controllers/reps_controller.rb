class RepsController < ApplicationController
  # GET /reps
  # GET /reps.json
  def index
    @reps = Rep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reps }
    end
  end

  # GET /reps/1
  # GET /reps/1.json
  def show
    @rep = Rep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rep }
    end
  end

  # GET /reps/new
  # GET /reps/new.json
  def new
    @rep = Rep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rep }
    end
  end

  # GET /reps/1/edit
  def edit
    @rep = Rep.find(params[:id])
  end

  # POST /reps
  # POST /reps.json
  def create
    @rep = Rep.new(params[:rep])

    respond_to do |format|
      if @rep.save
        format.html { redirect_to @rep, notice: 'Rep was successfully created.' }
        format.json { render json: @rep, status: :created, location: @rep }
      else
        format.html { render action: "new" }
        format.json { render json: @rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reps/1
  # PUT /reps/1.json
  def update
    @rep = Rep.find(params[:id])

    respond_to do |format|
      if @rep.update_attributes(params[:rep])
        format.html { redirect_to @rep, notice: 'Rep was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reps/1
  # DELETE /reps/1.json
  def destroy
    @rep = Rep.find(params[:id])
    @rep.destroy

    respond_to do |format|
      format.html { redirect_to @rep.user }
      format.json { head :no_content }
    end
  end
end
