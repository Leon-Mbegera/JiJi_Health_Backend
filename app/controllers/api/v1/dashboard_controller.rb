module Api
  module V1
    class DashboardController < ApplicationController
      before_action :authenticate_request!

      def index
        user_tasks = @current_user.tasks

        tasks_by_status = user_tasks.group(:status).count
        tasks_by_priority = user_tasks.group(:priority).count
        tasks_by_category = user_tasks.joins(:category).group('categories.name').count

        render json: {
          tasks_by_status: tasks_by_status,
          tasks_by_priority: tasks_by_priority,
          tasks_by_category: tasks_by_category
        }, status: :ok
      end
    end
  end
end
