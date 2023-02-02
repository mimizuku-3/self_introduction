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
    @introduction = Introduction.new(introduction_params)
    binding.pry
    @input_hobbies = @introduction.hobbies
    render :new unless @introduction.valid?
  end

  def create
    binding.pry
    @introduction = Introduction.new(introduction_params)
    binding.pry
    @hobby_ids = params[:hobby_ids]

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
    @introduction.attributes = introduction_params
    @input_hobbies = @introduction.hobbies
    @blob = ActiveStorage::Blob.last
    # binding.pry
    logger.debug("blobのsigned_id：#{@blob.signed_id}---------------------------------------------")
    path = params[:introduction][:image].original_filename
    @blob = ActiveStorage::Blob.create_and_upload!(io: params[:introduction][:image].tempfile, filename: path)
    session[:signed_id] = @blob.signed_id
    # @introduction.image.blob.save
    
    logger.debug("選択した画像のsigned_id：#{@introduction.image.signed_id}---------------------------------------------")
    render :edit unless @introduction.valid?
  end

  def update
    logger.debug("signed_id：#{@introduction.image.signed_id}---------------------------------------------")
    logger.debug("signed_id：#{params[:introduction][:blob_id]}---------------------------------------------")
    logger.debug("paramsのsigned_id：#{params[:introduction][:blob_id]}---------------------------------------------")
    # binding.pry
    logger.debug("signed_id2：#{session[:signed_id]}---------------------------------------------")
    
    
    # @introduction.attributes = introduction_params
    # logger.debug("signed_id2：#{@introduction.image.signed_id}---------------------------------------------")
    
    # path = "public/introductions_images/fテスト１.png"
    # blob = ActiveStorage::Blob.create_and_upload!(io: File.new(path),  filename: File.basename(path))
    # @introduction.image.attach(blob.signed_id)
    
    # binding.pry
    @hobby_ids=params[:hobby_ids]
    if params[:back].present?
      render :edit
      return
    end
    if @introduction.save
      @introduction.image.attach(session[:signed_id])
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
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content, :image, hobby_ids:[])
  end

  def introduction_params_edit
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content, :image, hobby_ids:[])


    logger.debug("画像のsigned_id：#{params[:introduction][:image]}")
    binding.pry
    @introduction.image.attach(params[:introduction][:image])
    binding.pry
  end

end
