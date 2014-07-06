class ChecklistsController < ApplicationController

  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.all
    @current_user = current_user
    @user_signed_in = user_signed_in?
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
  end

  # GET /checklists/new
  def new
    @checklist = Checklist.new
  end

  # GET /checklists/1/edit
  def edit

  end

  # POST /checklists
  # POST /checklists.json
  def create
    @checklist = Checklist.new(checklist_params)

    puts '-------------------'
    puts '-------------------'
    puts 'user debug         '
    puts @checklist.create_user
    puts '-------------------'
    @checklist.create_user = current_user

    respond_to do |format|
      if @checklist.save
        flash[:success] = 'Checklist was successfully created.'
        format.html { redirect_to checklists_url }
        format.json { render :show, status: :created, location: @checklist }
      else
        flash[:danger] = 'Error creating checklist.  '
        flash[:danger] += @checklist.errors.full_messages.first
        format.html { render :new }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklists/1
  # PATCH/PUT /checklists/1.json
  def update



    respond_to do |format|
      if @checklist.update(checklist_params)
        flash[:success] = 'Checklist was successfully updated.'
        format.html { redirect_to checklists_url }
        format.json { render :show, status: :ok, location: @checklist }
        puts '---------------------'
        puts 'CL Params ----found it-------'
        puts checklist_params
        puts '---------------------'
      else
        flash[:danger] = 'Error updating checklist.  '
        flash[:danger] += @checklist.errors.full_messages.first
        format.html { render :edit }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklists/1
  # DELETE /checklists/1.json
  def destroy
    @checklist.destroy
    respond_to do |format|
      flash[:success] = 'Checklist was successfully deleted'
      format.html { redirect_to checklists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
      @checklist_items = @checklist.checklist_items
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params.require(:checklist).permit(:name, :description, :expires_on, :create_user)
    end
end
