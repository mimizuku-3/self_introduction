class BasicWorkExperiencesController < ApplicationController
  before_action :find_basic_work_experience, only:[:show, :edit, :update]
  def show
  end

  def edit
  end

  def update
    if @basic_work_experience.update(basic_work_experience_params_edit)
      redirect_to basic_work_experience_path(@basic_work_experience), notice: "#{@basic_work_experience.introduction.name}さんの職務経歴書（基本情報）を更新しました。"
    else
      render :edit
    end
  end

  private
  def find_basic_work_experience
    @basic_work_experience = BasicWorkExperience.find(params[:id])
    if @basic_work_experience.discarded?
      flash[:notice] = "存在しない社員です。"
      redirect_to ("/")
    end
    @introduction = @basic_work_experience.introduction
  end

  def basic_work_experience_params_edit
    params.require(:basic_work_experience).permit(:affiliation, :nearest_station, :date_work_start, :is_married, :carrer_period, :strong_field, :strong_technology, :strong_business, :self_promotion)
  end
end
