class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :set_namespace

  def set_namespace
    @namespace = { action: params[:action], controller: params[:controller], id: params[:id] }
  end
end
