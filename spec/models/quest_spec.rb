require 'rails_helper'

RSpec.describe Quest, type: :model do
  # Unit Test - ทดสอบ Model

  describe "validations" do
    it "ต้องมี name" do
      quest = Quest.new(name: nil)
      expect(quest).not_to be_valid
      expect(quest.errors[:name]).to be_present
    end

    it "สามารถสร้าง quest ได้เมื่อมี name" do
      quest = Quest.new(name: "Test Quest")
      expect(quest).to be_valid
    end
  end

  describe "default values" do
    it "is_done ควรเป็น false เมื่อสร้างใหม่" do
      quest = Quest.create(name: "New Quest")
      expect(quest.is_done).to eq(false)
    end
  end
end
