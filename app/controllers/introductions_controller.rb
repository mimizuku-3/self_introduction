class IntroductionsController < ApplicationController
  before_action :find_introduction, only:[:show, :edit, :confirm_edit, :update]

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
    @input_hobbies = @introduction.hobbies
    render :new unless @introduction.valid?
  end

  def create
    @introduction = Introduction.new(introduction_params)
    @hobby_ids=params[:hobby_ids]

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
    render :edit unless @introduction.valid?
  end

  def update
    @introduction.attributes = introduction_params
    @hobby_ids=params[:hobby_ids]
    if params[:back].present?
      render :edit
      return
    end

    if @introduction.update(introduction_params)
      if @hobby_ids != nil
        @hobby_ids.each do |hobby_id|
          hobby_introduction = HobbyIntroduction.find_by(introduction_id: @introduction.id, hobby_id: hobby_id)
          # binding.pry
          if hobby_id.present? #チェックボックスがチェックされている。
            unless hobby_introduction.present? #【新規】hobby_introductionにレコードがない。
              # binding.pry
              hobby = Hobby.find(hobby_id)
              @introduction.hobbies << hobby
              logger.debug("作成")
              binding.pry
              @introduction.updated_at = Time.zone.now
              @introduction.save
            end
          else #チェックボックスがチェックされていない
            # binding.pry
            if hobby_introduction.present?
              hobby_introduction.destroy
              logger.debug("削除")
              binding.pry
              @introduction.updated_at = Time.zone.now
              @introduction.save
            end
          end
        end
      end
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

  def find_introduction
    @introduction = Introduction.find(params[:id])
  end

  private
  def introduction_params
    params.require(:introduction).permit(:name, :age, :sex, :prefecture_id, :address, :content, hobby_ids:[])
  end

end
