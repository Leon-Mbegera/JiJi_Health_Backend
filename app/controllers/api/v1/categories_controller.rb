module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_category, only: %i[show update destroy]

      def index
        @categories = Category.all
        render json: {
          categories: ActiveModelSerializers::SerializableResource.new(@categories, each_serializer: CategorySerializer)
        }, status: :ok
      end

      def show
        render json: {
          category: CategorySerializer.new(@category)
        }, status: :ok
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          render json: {
            category: CategorySerializer.new(@category)
          }, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: {
            category: CategorySerializer.new(@category)
          }, status: :ok
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
        head :no_content
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :description, :color)
      end
    end
  end
end
