require 'rails_helper'

feature "visiting the home page" do
  scenario "User sees Task Manager Header" do
    visit '/'
    expect(page).to have_content "Task Manager"
  end
end