class WorkExperiencesController < ApplicationController
  def edit
    @work_experience = WorkExperience.find(params[:id])
  end

  def update
    @work_experience = WorkExperience.find(params[:id])
    @introduction = @work_experience.introduction
    if @work_experience.update(work_experience_params)
      redirect_to basic_work_experience_path(@introduction.basic_work_experience), notice: "#{@introduction.name}さんの職務経歴を更新しました。"
    else
      render :edit
    end
  end

  private
  def work_experience_params
    params.require(:work_experience).permit(:project_name)
  end
end