module Api
  class TasksController < ApplicationController
    def index
      tasks = Task.all
      render json: tasks.to_json
    end

    def create
      task = Task.create!(name: params[:name], description: params[:description])
      render json: task.to_json
    end

    def update
      task = Task.find(params[:id])
      if task.update_attributes(name: params[:name], description: params[:description])
        render json: task.to_json
      else
        render json: {message: task.errors.full_messages.to_sentence}, status: :unprocessable_entity
      end
    end

    def destroy
      if Task.destroy(params[:id])
        head :no_content
      else
        head :unprocessable_entity
      end
    end

  end
end