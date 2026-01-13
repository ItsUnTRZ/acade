require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  # Integration Test - ทดสอบ Controller

  describe "GET #index" do
    it "แสดง quests ทั้งหมด" do
      quest1 = Quest.create!(name: "Quest 1")
      quest2 = Quest.create!(name: "Quest 2")

      get :index

      expect(assigns(:quests)).to include(quest1, quest2)
      expect(response).to have_http_status(:success)
    end

    it "สร้าง quest ใหม่สำหรับ form" do
      get :index

      expect(assigns(:quest)).to be_a_new(Quest)
    end
  end

  describe "POST #create" do
    it "สร้าง quest ใหม่ได้สำเร็จ" do
      expect {
        post :create, params: { quest: { name: "New Quest", is_done: false } }
      }.to change(Quest, :count).by(1)

      # HTML format จะ redirect (302) หรือ turbo_stream format จะ success (200)
      expect([ 200, 302, 303 ]).to include(response.status)
    end

    it "ไม่สามารถสร้าง quest ได้ถ้าไม่มี name" do
      expect {
        post :create, params: { quest: { name: nil } }
      }.not_to change(Quest, :count)
    end
  end

  describe "PATCH #update" do
    it "อัปเดต quest ได้สำเร็จ" do
      quest = Quest.create!(name: "Old Name", is_done: false)

      patch :update, params: { id: quest.id, quest: { name: "New Name", is_done: true } }

      quest.reload
      expect(quest.name).to eq("New Name")
      expect(quest.is_done).to eq(true)
      # HTML format จะ redirect (303) หรือ turbo_stream format จะ success (200)
      expect([ 200, 302, 303 ]).to include(response.status)
    end
  end

  describe "DELETE #destroy" do
    it "ลบ quest ได้สำเร็จ" do
      quest = Quest.create!(name: "To Delete")

      expect {
        delete :destroy, params: { id: quest.id }
      }.to change(Quest, :count).by(-1)

      # HTML format จะ redirect (303) หรือ turbo_stream format จะ success (200)
      expect([ 200, 302, 303 ]).to include(response.status)
    end
  end
end
