# frozen_string_literal: true

module Api
  module Version1
    class ArticlesController < ApplicationController
      # skip_before_action :verify_authenticity_token
      #   respond_to :json

      def index
        articles = Article.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded articles', data: articles }, status: 200
      end

      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loading article at index', data: article }, status: 200
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: { status: 'SUCCESS', message: 'Saved article', data: article }, status: 200
        else
          render json: { status: 'ERROR', message: 'Failed to save article to database', data: article.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: { status: 'SUCCESS', message: 'Article deleted', data: article }, status: 200
      end

      def update
        article = Article.find(params[:id])
        if article.update(article_params)
          render json: { status: 'SUCCESS', message: 'Article updated', data: article }, status: 200
        else
          render json: { status: 'ERROR', message: 'Article not updated', data: article.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.require(:article).permit(:title, :body)
      end
    end
  end
end
