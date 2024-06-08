class OwnersController < ApplicationController
  before_action :set_owner, only: %i[ show update destroy ]

  def index
    @owners = Owner.all
  end

  def show
  end

  def create
    @owner = Owner.new(owner_params)

    respond_to do |format|
      if @owner.save
        format.json { render :show, status: :created, location: @owner }
      else
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.json { render :show, status: :ok, location: @owner }
      else
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @owner.destroy
        format.json { head :no_content }
      else
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_owner
      @owner = Owner.find(params[:id])
    end

    def owner_params
      params.require(:owner).permit(:name)
    end
end
