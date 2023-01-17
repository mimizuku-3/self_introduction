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

  def edit
    @introduction = Introduction.find(params[:id])
  end

  def confirm_edit
    @introduction = Introduction.find(params[:id])
    @introduction.attributes = introduction_params
    render :edit unless @introduction.valid?
  end

  def update
    @introduction = Introduction.find(params[:id])
    @introduction.attributes = introduction_params
    if params[:back].present?
      render :edit
      return
    end
    if @introduction.update!(introduction_params)
      redirect_to complete_introductions_path
    else
      render :edit
    end
  end

  def introduction_params
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content)
  end

end
