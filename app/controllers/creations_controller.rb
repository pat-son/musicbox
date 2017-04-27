class CreationsController < ApplicationController
  def index
    sort = params[:sort]
    sort_types = ["created_at DESC", "created_at ASC", "viewcount DESC", "viewcount ASC"]
    sort = "created_at DESC" unless sort_types.include?(sort)
    @creations = Creation.search(params[:search], sort)
    @creations = @creations.paginate(page: params[:page], per_page: 16)
  end
  
  def new
    @creation = Creation.new
  end

  def edit
    @creation = Creation.find(params[:id])
  end

  def sequence
  end

  def create
    @creation = Creation.new(creation_params)
    @creation.user_id = (current_user).id
    if @creation.save
      respond_to do |format|
        msg = { message: 'Success!', redirect: creations_path }
        format.json  { render json: msg, status: 200 }
      end
    else
      respond_to do |format|
        msg = { message: @creation.errors.full_messages }
        format.json  { render json: msg, status: 500 }
      end
    end
  end

  def update
    @creation = Creation.find(params[:id])
    update = creation_params
    respond_to do |format|
      if helpers.can_edit?(@creation) and @creation.update_attributes(update)
        msg = { message: 'Success!' }
        format.json  { render json: msg, status: 200 }
      else
        msg = { message: @creation.errors.full_messages }
        format.json  { render json: msg, status: 500 }
      end
    end
  end

  def show
    @creation = Creation.find(params[:id])
    @comments = @creation.comments

    #add view
    @creation.viewcount += 1
    @creation.save
  end

  def destroy
    @creation = Creation.find(params[:id])
    if helpers.can_edit?(@creation) and @creation.destroy
      flash[:success] = "Successfully deleted creation."
      redirect_to creations_path
    else
      flash[:danger] = "Could not delete project: " + @creation.errors.full_messages
      redirect_to [:edit, @creation]
    end
  end

  private
    def creation_params
      params.permit(:name, :data, :id)
    end
end
