require 'rails_helper'

RSpec.describe "Quests", type: :system do
  # UI Test - ทดสอบ User Interface

  before do
    driven_by(:selenium_chrome_headless)
  end

  it "ผู้ใช้สามารถสร้าง quest ใหม่ได้" do
    visit root_path

    # หา input field สำหรับ quest name (อาจเป็น quest_name หรือ new_quest_name)
    fill_in "quest_name", with: "My First Quest", match: :first
    click_button "Add Quest"

    # รอให้ Turbo Stream update
    sleep 0.5

    expect(page).to have_content("My First Quest")
  end

  it "ผู้ใช้สามารถติ๊ก checkbox เพื่อทำ quest เสร็จได้" do
    quest = Quest.create!(name: "Test Quest", is_done: false)

    visit root_path

    # หา checkbox ของ quest
    checkbox = find("input[type='checkbox'][data-controller='checkbox']", match: :first)
    checkbox.check

    # รอให้ Turbo Stream update
    sleep 0.5

    expect(checkbox).to be_checked
  end

  it "ผู้ใช้สามารถลบ quest ได้" do
    quest = Quest.create!(name: "Quest to Delete")

    visit root_path

    expect(page).to have_content("Quest to Delete")

    # หา delete link และคลิก (ไม่มี confirmation แล้ว)
    find("a[href='#{quest_path(quest)}'][data-turbo-method='delete']").click

    # รอให้ Turbo Stream update
    sleep 0.5

    expect(page).not_to have_content("Quest to Delete")
  end

  it "แสดง empty state เมื่อไม่มี quests" do
    visit root_path

    expect(page).to have_content("No quests yet")
  end
end
