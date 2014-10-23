class PersonalsController < ApplicationController
  before_action :user_signed_in

  def index
    @personals = Personal.all.order("created_at DESC")
  end

  def new
    @personal = Personal.new
  end

  def create
    @personal = Personal.new(personal_params)
    @personal.user = current_user
    if @personal.save
      flash[:success] = "Personal created"
      redirect_to @personal
    else
      render 'new'
    end
  end

  def edit
    @personal = Personal.find(params[:id])
  end

  def update
    @personal = Personal.find(params[:id])
    if @personal.update!(personal_params)
      flash[:success] = "Personal updated"
      redirect_to @personal
    else
      render 'edit'
    end
  end

  def destroy
    personal = Personal.find(params[:id])
    personal.destroy
    flash[:info] = "Personal deleted"
    redirect_to personals_url
  end

  def show
    @personal = Personal.find(params[:id])
  end

  private

  def personal_params
    params.require(:personal).permit(:name, :description)
  end

  def user_signed_in
    unless user_signed_in?
      flash[:error] = "Sign in first"
      redirect_to root_url
    end
  end
end