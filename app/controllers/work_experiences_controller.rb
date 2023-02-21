class WorkExperiencesController < ApplicationController
  before_action :find_work_experience, only:[:edit, :update, :destroy]

  def new
    @introduction = Introduction.find(params[:id])
    @work_experience = WorkExperience.new
  end

  def create
    @introduction = Introduction.find(params[:id])
    @work_experience = WorkExperience.new(introduction_id: @introduction.id)
    @work_experience.attributes = work_experience_params
    roles = params[:work_experience][:role]
    @work_experience.set_role_by_bit_management(roles)
    if @work_experience.save
      redirect_to basic_work_experience_path(@introduction.basic_work_experience), notice: "#{@introduction.name}さんの職務経歴を追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @introduction = @work_experience.introduction
    @work_experience.attributes = work_experience_params
    roles = params[:work_experience][:role]
    @work_experience.set_role_by_bit_management(roles)
    if @work_experience.save
      redirect_to basic_work_experience_path(@introduction.basic_work_experience), notice: "#{@introduction.name}さんの職務経歴を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @work_experience.discard
    @introduction = @work_experience.introduction
    redirect_to basic_work_experience_path(@introduction.basic_work_experience), notice: "#{@work_experience.project_name} の職務経歴を削除しました。"
  end

  private
  def find_work_experience
    @work_experience = WorkExperience.find(params[:id])
    if @work_experience.discarded?
      flash[:notice] = "存在しない職務経歴です。"
      redirect_to ("/")
    end
  end

  def work_experience_params
    params.require(:work_experience).permit(:start_month, :end_month, :project_name, :project_detail, :role, :role_description, :language, :database, :server, :fw_mw_tool_etc, :responsible_process)
  end
end