class CreationsController < ApplicationController
  def index
    @creations = Creation.all
  end
  
  def new
    @creation = Creation.new
  end

  def create
    @creation = Creation.new(creation_params)
    @creation.user_id = (current_user).id
    if @creation.save
      redirect_to @creation
    else
      flash[:danger] = "Invalid information."
      render 'new'
    end
  end

  def show
    @creation = Creation.find(params[:id])
    @comments = @creation.comments
  end

  private
    def creation_params
      params.require(:creation).permit(:name, :data)
    end
end
