class BasicWorkExperiencesController < ApplicationController
  before_action :find_basic_work_experience

  def show
    @work_experiences = WorkExperience.where(introduction_id: @introduction.id).order(start_month: :desc)
  end

  def edit
  end

  def update
    @basic_work_experience.attributes = basic_work_experience_params_edit
    if @basic_work_experience.update(basic_work_experience_params_edit)
      redirect_to basic_work_experience_path(@introduction), notice: "#{@introduction.name}さんの職務経歴書（基本情報）を更新しました。"
    else
      render :edit
    end
  end

  private
  def find_basic_work_experience
    @introduction = Introduction.find(params[:id])
    @basic_work_experience = @introduction.basic_work_experience
  end

  def basic_work_experience_params_edit
    params.require(:basic_work_experience).permit(:affiliation, :nearest_station, :date_work_start, :is_married, :carrer_period, :strong_field, :strong_technology, :strong_business, :self_promotion)
  end
end
