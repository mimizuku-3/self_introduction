class IntroductionsController < ApplicationController
  def index
    @introductions = Introduction.all
  end

  def new
    @introduction = Introduction.new
  end

  def confirm_new
    @introduction = Introduction.new(introduction_params)
    render :new unless @introduction.valid?
  end

  def create
    @introduction = Introduction.new(introduction_params)
    if params[:back].present?
      render :new
      return
    end
    if @introduction.save
      redirect_to complete_introductions_path
    else
      render :new
    end
  end

  def complete

  end

  def show
    @introduction = Introduction.find(params[:id])
  end

  def introduction_params
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content)
  end

end
