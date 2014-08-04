class ChecklistsController < ApplicationController

  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # GET /checklists
  # GET /checklists.json
  def index
    if user_signed_in?
      @checklists = Checklist.for_user_id(current_user.id)
    else
      @checklists = Checklist.all
    end
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
    @checklist.assigned_to_email = current_user.email
    @checklist.start_on = Date.today
    @checklist.expires_on = 1.month.since(@checklist.start_on)
    #@checklist.recur_on = "Every Day"  #mmt, no default now, non-recurring is the default
    @users = User.all
    @checklist.assigned_to_id = current_user.id   #might need IDs
  end

  # GET /checklists/1/edit
  def edit
    @users = User.all
    @new_checklist_item = ChecklistItem.new(:checklist_id => @checklist.id)
  end

  # POST /checklists
  # POST /checklists.json
  def create
    @checklist = Checklist.new(checklist_params)

    @checklist.create_user = current_user

    #Lookup ID if it exists
    assignee = User.find_by(email: @checklist.assigned_to_email)
    if !assignee.nil?
      @checklist.assigned_to_id = assignee.id
    end

    respond_to do |format|
      if @checklist.save
        flash[:success] = 'Your checklist was successfully created!  Now add items to it!'
        format.html { redirect_to edit_checklist_path(@checklist.id) }
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

    #Set Assigned Use if exists
    assignee = User.find_by(email: @checklist.assigned_to_email)
    if !assignee.nil?
      @checklist.assigned_to_id = assignee.id
    else
      @checklist.assigned_to_id = nil
    end

    respond_to do |format|
      if @checklist.update(checklist_params)
        flash[:success] = 'Checklist was successfully updated.'
        format.html { redirect_to checklists_url }
        format.json { render :show, status: :ok, location: @checklist }
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
    def set_assignee(checklist)
      if !checklist.nil?
        checklist.assigned_to_id = User.find_by email: checklist.assigned_to_email
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
      @checklist_items = @checklist.checklist_items.sorted
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params.require(:checklist).permit(:name, :description, :expires_on, :create_user, :recur_on, :assigned_to_id,
                                        :assigned_to_email, :start_on, :notify_hour)
    end
end
