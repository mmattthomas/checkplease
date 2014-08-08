class TaskItemsController < ApplicationController
  before_action :set_task_item, only: [:show, :edit, :update, :destroy]

  # GET /task_items
  # GET /task_items.json
  def index
    @task_items = TaskItem.all
  end

  # GET /task_items/1
  # GET /task_items/1.json
  def show
  end

  # GET /task_items/new
  def new
    @task_item = TaskItem.new
  end

  # GET /task_items/1/edit
  def edit
  end

  # POST /task_items
  # POST /task_items.json
  def create
    @task_item = TaskItem.new(task_item_params)

    respond_to do |format|
      if @task_item.save
        format.html { redirect_to @task_item, notice: 'Task item was successfully created.' }
        format.json { render :show, status: :created, location: @task_item }
      else
        format.html { render :new }
        format.json { render json: @task_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_items/1
  # PATCH/PUT /task_items/1.json
  def update
    respond_to do |format|
      if @task_item.update(task_item_params)
        @ajax_response = "hi!"
        #TODO - mark task's % completion
        pct_complete = (@task_item.task.task_items.complete.length / @task_item.task.task_items.length.to_f) * 100
        @task_item.task.update_attribute :percent_complete, pct_complete.to_i
        @task_item.task.update_attribute :complete, (pct_complete.to_i == 100)
        format.html { redirect_to @task_item, notice: 'Task item was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_item }
        #format.json { respond_with_bip(@task_item) }
      else
        format.html { render :edit }
        format.json { render json: @task_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_items/1
  # DELETE /task_items/1.json
  def destroy
    @task_item.destroy
    respond_to do |format|
      format.html { redirect_to task_items_url, notice: 'Task item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_item
      @task_item = TaskItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_item_params
      params.require(:task_item).permit(:task_id, :checklist_id, :checklist_item_id, :completed, :notes)
    end
end
