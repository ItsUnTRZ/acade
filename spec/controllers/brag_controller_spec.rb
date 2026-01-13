require 'rails_helper'

RSpec.describe BragController, type: :controller do
  # Integration Test - ทดสอบ Brag Controller
  render_views

  describe "GET #index" do
    it "แสดงหน้า brag document ได้สำเร็จ" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "แสดงเนื้อหาหลักของ brag document" do
      get :index

      expect(response.body).to include("My Brag Document")
    end
  end
end
