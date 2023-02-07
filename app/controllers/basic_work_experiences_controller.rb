class BasicWorkExperiencesController < ApplicationController
  def show
    @introduction = Introduction.find(params[:id])
    @basic_work_experience = @introduction.basic_work_experience
  end

  def edit
    @introduction = Introduction.find(params[:id])
    @basic_work_experience = @introduction.basic_work_experience
  end

  def update
    @introduction = Introduction.find(params[:id])
    @basic_work_experience = @introduction.basic_work_experience
    @basic_work_experience.attributes = basic_work_experience_params_edit
    if @basic_work_experience.update(basic_work_experience_params_edit)
      redirect_to basic_work_experience_path(@introduction), notice: "#{@introduction.name}さんの職務経歴書（基本情報）を更新しました。"
    else
      render :edit
    end
  end

  private
  def basic_work_experience_params_edit
    params.require(:basic_work_experience).permit(:affiliation, :nearest_station, :date_work_start, :is_married, :carrer_period, :strong_field, :strong_technology, :strong_business, :self_promotion)
  end
end
