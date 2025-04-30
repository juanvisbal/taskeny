class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @filter = params[:filter] || 'all'
    
    @tasks = case @filter
             when 'pending'
               Task.pending.order(created_at: :desc)
             when 'completed'
               Task.completed.order(created_at: :desc)
             else
               Task.all.order(created_at: :desc)
             end

  end

  def show
  end
  
  def new
    @task = Task.new
    
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def create
    @task = Task.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
        format.turbo_stream do
          flash.now[:notice] = "Task was successfully created."
          render turbo_stream: [
            turbo_stream.prepend("tasks-list", partial: "tasks/task", locals: { task: @task }),
            turbo_stream.replace("task_form", ""),
            turbo_stream.replace("flash", partial: "shared/flash"),
            turbo_stream.replace("modal", "")
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "Task was successfully updated." }
        format.turbo_stream do
          flash.now[:notice] = "Task was successfully updated."
          render turbo_stream: [
            turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task }),
            turbo_stream.replace("task_form", ""),
            turbo_stream.replace("flash", partial: "shared/flash"),
            turbo_stream.replace("modal", "")
          ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @task.destroy
    
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was successfully deleted." }
      format.turbo_stream { flash.now[:notice] = "Task was successfully deleted." }
    end
  end
  
  def toggle
    @task.update(completed: !@task.completed)
    
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.turbo_stream
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority, :completed)
  end
end
