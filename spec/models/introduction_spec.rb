require 'rails_helper'

RSpec.describe Introduction, type: :model do
  before do
    @introduction = FactoryBot.create(:introduction)
    @introduction2 = FactoryBot.create(:introduction)
  end

  it "has a valid factory" do
    expect(@introduction).to be_valid
  end

  context "validation" do
    it "does not allow name is blank" do
      @introduction.name = ""
      @introduction.valid?
      expect(@introduction.errors[:name]).to include("を入力してください")
    end
    
    it "does not allow furigana is blank" do
      @introduction.furigana = ""
      @introduction.valid?
      expect(@introduction.errors[:furigana]).to include("を入力してください")
    end

    it "does not allow full-width katakana in furigana" do
      @introduction.furigana = "フリガナ"
      expect(@introduction).to be_valid
    end

    it "allow half-width katakana in furigana" do
      @introduction.furigana = "ﾌﾘｶﾞﾅ"
      @introduction.valid?
      expect(@introduction.errors[:furigana]).to include("は全角カタカナで入力して下さい。")
    end

    it "does not allow age is blank" do
      @introduction.age = ""
      @introduction.valid?
      expect(@introduction.errors[:age]).to include("を入力してください")
    end

    it "does not allow sex is blank" do
      @introduction.sex = ""
      @introduction.valid?
      expect(@introduction.errors[:sex]).to include("を入力してください")
    end

    it "does not allow address is blank" do
      @introduction.address = ""
      @introduction.valid?
      expect(@introduction.errors[:address]).to include("を入力してください")
    end

    it "does not allow prefecture_id is blank" do
      @introduction.prefecture_id = ""
      @introduction.valid?
      expect(@introduction.errors[:prefecture_id]).to include("を入力してください")
    end
  end

  context "work_experiences" do
    before do
      @work_experience = FactoryBot.create(:work_experience, introduction: @introduction)
      @first_work_experience = FactoryBot.create(:work_experience, :first_work_experience, introduction: @introduction)
      @last_work_experience = FactoryBot.create(:work_experience, :last_work_experience, introduction: @introduction)
      @discarded_work_experience = FactoryBot.create(:work_experience, discarded_at: "2023-02-17", introduction: @introduction)
      @orderedWorkExperiences = @introduction.work_experiences
    end
    it "returns order by start_month desc" do
      expect(@orderedWorkExperiences[0]).to eq(@last_work_experience)
      expect(@orderedWorkExperiences[1]).to eq(@work_experience)
      expect(@orderedWorkExperiences[2]).to eq(@first_work_experience)
    end
    it "does not return discarded work_experiences" do
      expect(@orderedWorkExperiences).to_not include(@discarded_work_experience)
    end
  end

  it "recent scope returns order by created_at desc" do
    orderedIntroductions = Introduction.recent
    expect(orderedIntroductions[0]).to eq(@introduction2)
    expect(orderedIntroductions[1]).to eq(@introduction)
  end
end