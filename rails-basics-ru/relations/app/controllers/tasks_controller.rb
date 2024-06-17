# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.includes(:user, :status).all
  end

  def show; end

  def new
    @task = Task.new
    @users = User.all
    @statuses = Status.all
  end

  def edit
    @users = User.all
    @statuses = Status.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      @users = User.all
      @statuses = Status.all
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      @users = User.all
      @statuses = Status.all
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :status_id)
  end
end
