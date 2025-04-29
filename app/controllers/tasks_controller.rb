class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @tasks = Task.all
    
    @tasks = case params[:filter]
             when 'pending'
               @tasks.pending
             when 'completed'
               @tasks.completed
             else
               @tasks
             end
             
    @filter = params[:filter] || 'all'
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Task was successfully created." }
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
        format.html { redirect_to task_path(@task), notice: "Task was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Task was successfully updated." }
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
    @task.toggle_completion!
    
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
    params.require(:task).permit(:title, :description, :completed)
  end
end