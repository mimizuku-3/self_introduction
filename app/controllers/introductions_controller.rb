class IntroductionsController < ApplicationController
  before_action :find_introduction, only:[:show, :edit, :confirm_edit, :update, :destroy]

  def index
    @q = Introduction.ransack(params[:q])
    @introductions = @q.result(distinct: true).recent
    @sexes = Introduction.sexes_i18n
  end

  def new
    @introduction = Introduction.new
  end

  def confirm_new
    @introduction = Introduction.new(introduction_params_edit)
    @input_hobbies = @introduction.hobbies
    if params[:introduction][:image].present?
      path = params[:introduction][:image].original_filename
      @blob = ActiveStorage::Blob.create_and_upload!(io: params[:introduction][:image].tempfile, filename: path)
      session[:signed_id] = @blob.signed_id
    end
    render :new unless @introduction.valid?
  end

  def create
    @introduction = Introduction.new(introduction_params_edit)
    if params[:back].present?
      render :new
      return
    end
    
    if @introduction.save
      if @hobby_ids != nil
        @hobby_ids.each do |hobby_id|
          hobby = Hobby.find(hobby_id)
          @introduction.hobbies << hobby
        end
      end
      @introduction.image.attach(session[:signed_id]) if session[:signed_id].present?
      session[:signed_id] = nil

      binding.pry
      @introduction.create_basic_work_experience
      redirect_to complete_introductions_path
    else
      render :new
    end
  end


  def complete
  end

  def show
    @input_hobbies = @introduction.hobbies
  end

  def edit
  end

  def confirm_edit
    @introduction.attributes = introduction_params_for_edit_confirm
    @input_hobbies = params[:introduction][:hobby_ids]
    @input_hobbies.shift

    if params[:introduction][:image].present?
      path = params[:introduction][:image].original_filename
      @blob = ActiveStorage::Blob.create_and_upload!(io: params[:introduction][:image].tempfile, filename: path)
      session[:signed_id] = @blob.signed_id
    end

    render :edit unless @introduction.valid?
  end

  def update
    @hobby_ids=params[:hobby_ids]
    @introduction.attributes = introduction_params_edit
    if params[:back].present?
      render :edit
      return
    end
    if @introduction.update(introduction_params_edit)

      # introductionとimageをActiveStorage::Attachmentに紐づけ
      @introduction.image.attach(session[:signed_id]) if session[:signed_id].present?
      session[:signed_id] = nil
      redirect_to complete_introductions_path
    else
      render :edit
    end
  end

  def destroy
    @introduction.destroy
    redirect_to introductions_url, notice: "#{@introduction.name} さんの自己紹介を削除しました。"
  end

  private
  def find_introduction
    @introduction = Introduction.find(params[:id])
  end

  def introduction_params
    params.require(:introduction).permit(:name, :furigana, :age, :sex, :prefecture_id, :address, :content, :image, hobby_ids:[])
  end

  def introduction_params_edit
    params.require(:introduction).permit(:name, :furigana, :age, :sex, :prefecture_id, :address, :content, hobby_ids:[])
  end

  def introduction_params_for_edit_confirm
    params.require(:introduction).permit(:name, :furigana, :age, :sex, :prefecture_id, :address, :image, :content)
  end
end
