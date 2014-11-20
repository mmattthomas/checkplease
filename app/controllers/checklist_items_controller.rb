class ChecklistItemsController < ApplicationController
  before_action :set_checklist_item, only: [:show, :edit, :update, :destroy]


  # GET /checklist_items
  # GET /checklist_items.json
  def index
    @checklist_items = ChecklistItem.all
  end

  # GET /checklist_items/1
  # GET /checklist_items/1.json
  def show
  end

  # GET /checklist_items/new
  def new
    @all_checklists = Checklist.all
    @checklist_item = ChecklistItem.new   # {:checklist_id => @checklist.id}
    if params[:checklist_id]
      @checklist = Checklist.find(params[:checklist_id])
      @checklist_item.checklist_id = @checklist.id
    end
  end

  # GET /checklist_items/1/edit
  def edit
    puts '-####CLI EDIT####-'
    @all_checklists = Checklist.all
  end

  # POST /checklist_items
  # POST /checklist_items.json
  def create
    @checklist_item = ChecklistItem.new(checklist_item_params)

    respond_to do |format|
      if @checklist_item.save
        #flash[:success] = 'Checklist item was successfully created!'
        format.html { redirect_to controller: 'checklists', action: 'edit', id: @checklist_item.checklist_id }
        format.json { render :show, status: :created, location: @checklist_item }
      else
        format.html { render :new }
        format.json { render json: @checklist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklist_items/1
  # PATCH/PUT /checklist_items/1.json
  def update

    puts '-####CLI UPDATE####-'
    puts '-Params: '
    puts checklist_item_params
    puts '-item:'
    print @checklist_item.id
    print ' - '
    print @checklist_item.check_name
    puts '-##################-'

    respond_to do |format|
      if @checklist_item.update(checklist_item_params)
        flash[:success] = 'Checklist item was successfully updated.'
        format.html { redirect_to controller: 'checklists', action: 'edit', id: @checklist_item.checklist_id }
        #format.json { render :show, status: :ok, location: @checklist_item }
        format.json { respond_with_bip(@checklist_item) }
      else
        format.html { render :edit }
        format.json { render json: @checklist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_items/1
  # DELETE /checklist_items/1.json
  def destroy
    parent_checklist_id = @checklist_item.checklist_id
    @checklist_item.destroy
    flash[:success] = "Checklist item was successfully destroyed."
    respond_to do |format|
      format.html { redirect_to controller: 'checklists', action: 'edit', id: parent_checklist_id }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist_item
      @checklist_item = ChecklistItem.find(params[:id])
    end

    def get_parent_checklist
      if params[:checklist_id]
        @checklist = Checklist.find(params[:checklist_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_item_params
      params.require(:checklist_item).permit(:check_name, :check_description, :checklist_id)
    end
end
