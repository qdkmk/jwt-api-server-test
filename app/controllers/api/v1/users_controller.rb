# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, except: %i[create logout]
  def index
    render json: { status: 200, user: response_fields(current_user.to_json) }
  end

  private

  def response_fields(user_json)
    user_parse = JSON.parse(user_json)
    user_parse.except('created_at', 'updated_at', 'password', 'password_digest')
  end
end
