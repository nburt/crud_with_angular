require 'rails_helper'

describe "CRUDing Tasks" do
  describe "Creating a task" do
    it "returns json upon a successful task creation" do
      post "/api/tasks", {name: "Get Groceries", description: "Monday"}

      task = Task.last

      expected_response = {
        id: task.id,
        name: "Get Groceries",
        description: "Monday",
        created_at: task.created_at
      }.to_json

      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end

  end

  describe "getting list of tasks" do
    it "returns json for all tasks on a successful get to /api/tasks" do

      task1 = Task.create!(name: "Get Groceries", description: "Monday")
      task2 = Task.create!(name: "Wash Clothes", description: "Saturday")
      task3 = Task.create!(name: "Mow Lawn", description: "Sunday")

      get "/api/tasks"

      expected_response = [
        {
          id: task1.id,
          name: task1.name,
          description: task1.description,
          created_at: task1.created_at
        },
        {
          id: task2.id,
          name: task2.name,
          description: task2.description,
          created_at: task2.created_at
        },
        {
          id: task3.id,
          name: task3.name,
          description: task3.description,
          created_at: task3.created_at
        }
      ].to_json

      expect(response.body).to eq expected_response
    end
  end
end


