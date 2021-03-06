class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def create
    sub = Sub.new(sub_params)
    debugger
    sub.moderator_id = current_user.id
    if sub.save
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      render :new
    end
  end

  def update
    sub = Sub.find(params[:id])
    if sub.update_attributes(sub_params)
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
