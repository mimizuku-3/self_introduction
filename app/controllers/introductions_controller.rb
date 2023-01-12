class IntroductionsController < ApplicationController
  def index
  end

  def new
    @introduction = Introduction.new
  end

  def confirm
    @introduction = Introduction.new(introduction_params)
    # @name = params[:name]
    # @content = params[:content]
  end

  def introduction_params
    params.require(:introduction).permit(:name, :content)
  end
end
