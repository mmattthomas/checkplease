class TasksController < ApplicationController

  def edit
    @user = current_user
    @task = Task.find params[:id]
    @checklist = @task.checklist
    @task_items = @task.task_items
  end

  def show
    @user = current_user
    @task = Task.find params[:id]
    @checklist = @task.checklist
    @task_items = @task.task_items
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.save
        flash[:success] = 'Tasklist was successfully updated.'
        format.html { render :show }
        format.json { render :show, status: :ok, location: @task }
      else
        flash[:danger] = 'Error updating tasklist.  '
        flash[:danger] += @task.errors.full_messages.first
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name)
    end
end
