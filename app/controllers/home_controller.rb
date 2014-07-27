class HomeController < ApplicationController
  def index
    @task = Task.new
  end
end