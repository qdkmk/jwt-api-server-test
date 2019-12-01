# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Common
  include ExceptionHandler
end
