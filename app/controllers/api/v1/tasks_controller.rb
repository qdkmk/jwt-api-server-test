# frozen_string_literal: true

class Api::V1::TasksController < ApplicationController
  # skip_before_action :verify_authenticity_token
  include Common
  before_action :authenticate_user
  before_action :set_task, only: %i[show update destroy]
  def index
    @tasks = current_user.tasks
    json_response(@tasks)
  end

  def show
    if @task.user != current_user
      response_unauthorized
    else
      json_response(@task)
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.title.blank? || @task.description.blank?
      response_bad_request
    else
      if Task.exists?(description: @task.description, user: current_user)
        response_conflict(:task)
      else
        @task.user = current_user
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
  end

  def update
    @task.update(task_params)
    response_success(:task, :update)
  end

  def destroy
    @task.destroy
    response_success(:task, :destroy)
    # head :no_content
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def task_params
    params.permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end