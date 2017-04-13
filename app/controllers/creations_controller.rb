class CreationsController < ApplicationController
  def index
    @creations = Creation.all
  end
  
  def new
    @creation = Creation.new
  end

  def sequence
  end

  def create
    @creation = Creation.new(creation_params)
    @creation.user_id = (current_user).id
    if @creation.save
      respond_to do |format|
        msg = { message: 'Success!', redirect: creations_path }
        puts msg
        format.json  { render json: msg, status: 200 }
      end
    else
      respond_to do |format|
        msg = { message: @creation.errors.full_messages }
        format.json  { render json: msg, status: 500 }
      end
    end
  end

  def show
    @creation = Creation.find(params[:id])
    @comments = @creation.comments
  end

  private
    def creation_params
      params.permit(:name, :data)
    end
end
