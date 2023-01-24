class IntroductionsController < ApplicationController
  before_action :find_introduction, only:[:show, :edit, :confirm_edit, :update]

  def index
    @q = Introduction.ransack(params[:q])
    @introductions = @q.result(distinct: true).recent
    @sexes = Introduction.sexes_i18n
    # @introductions = Introduction.all
  end

  def new
    @introduction = Introduction.new
    @hobby_introductions = @introduction.hobby_introductions.build
  end

  def confirm_new
    @introduction = Introduction.new(introduction_params)
    @hobby_introductions = @introduction.hobby_introductions.build
    binding.pry
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
  end

  def edit
  end

  def confirm_edit
    @introduction.attributes = introduction_params
    render :edit unless @introduction.valid?
  end

  def update
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

  def destroy
    introduction = Introduction.find(params[:id])
    introduction.destroy
    redirect_to introductions_url, notice: "#{introduction.name} さんの自己紹介を削除しました。"
  end

  def introduction_params
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content,
      hobby_introductions: [:hobby_id]
    )
  end

  def find_introduction
    @introduction = Introduction.find(params[:id])
  end

end
