class BasicWorkExperiencesController < ApplicationController
  def show
    @introduction = Introduction.find(params[:id])
    @basic_work_experience = @introduction.basic_work_experience
  end
end
