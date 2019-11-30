# frozen_string_literal: true

class Api::V1::TasksController < ApplicationController
  # skip_before_action :verify_authenticity_token
  include Common
  before_action :authenticate_user
  before_action :set_task, only: %i[show update destroy]
  def index
    json_response(Task.all)
  end

  def show
    json_response(@tasks)
  end

  def create
    @task = Task.new(task_params)
    if @task.title.blank?
      response_bad_request
    else
      if Task.exists?(description: @task.description)
        response_conflict(:task)
      else
        if @task.save!
          response_success(:task, :create)
        else
          response_internal_server_error
        end
      end
    end
  end

  def new; end

  def edit
    @task = target_task params[:id]
  end

  def update
    @task.update(task_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def target_task(task_id)
    current_user.tasks.where(id: task_id).take
  end

  def task_params
    params.permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end