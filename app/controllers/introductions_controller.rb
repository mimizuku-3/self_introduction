class IntroductionsController < ApplicationController
  def index
  end

  def new
    @introduction = Introduction.new
  end

  def confirm
    @introduction = Introduction.new(introduction_params)
  end

  def create
    @introduction = Introduction.new(introduction_params)
    @introduction.save
    redirect_to complete_introductions_path
  end

  def complete

  end

  def introduction_params
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content)
  end
end
