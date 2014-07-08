module Api
  class TasksController < ApplicationController
    def index
      tasks = Task.all
      tasks_array = tasks.map do |task|
        {
          id: task.id,
          name: task.name,
          description: task.description,
          created_at: task.created_at
        }
      end

      render json: tasks_array.to_json
    end

    def create
      task = Task.create!(name: params[:name], description: params[:description])
      json = {
        id: task.id,
        name: task.name,
        description: task.description,
        created_at: task.created_at
      }.to_json
      render json: json
    end
  end
end