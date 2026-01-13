require 'rails_helper'

RSpec.describe "Brag Document", type: :system do
  # UI Test - ทดสอบ Brag Document Page

  before do
    driven_by(:selenium_chrome_headless)
  end

  it "ผู้ใช้สามารถเข้าถึงหน้า brag document ได้" do
    visit brag_path

    expect(page).to have_content("My Brag Document")
  end

  it "ผู้ใช้สามารถกลับไปหน้า home ได้" do
    visit brag_path

    click_link "Back to Home"

    expect(page).to have_current_path(root_path)
  end

  it "แสดงเนื้อหาหลักของ brag document" do
    visit brag_path

    expect(page).to have_content("เป้าหมายของฉัน")
    expect(page).to have_content("ความสำเร็จที่ผ่านมา")
    expect(page).to have_content("ทักษะที่ฉันมี")
  end
end
