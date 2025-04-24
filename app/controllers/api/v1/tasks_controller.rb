module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_request!
      before_action :set_task, only: %i[show update destroy]

      def index
        @tasks = @current_user.tasks.all
        render json: {
          tasks: ActiveModelSerializers::SerializableResource.new(@tasks, each_serializer: TaskSerializer)
        }, status: :ok
      end

      def show
        render json: {
          task: TaskSerializer.new(@task)
        }, status: :ok
      end

      def create
        @task = @current_user.tasks.new(task_params)

        if @task.save
          render json: {
            task: TaskSerializer.new(@task)
          }, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: {
            task: TaskSerializer.new(@task)
          }, status: :ok
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_task
        @task = @current_user.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :due_date, :priority, :status, :category_id)
      end
    end
  end
end
