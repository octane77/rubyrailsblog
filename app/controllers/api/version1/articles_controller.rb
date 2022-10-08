module Api
  module Version1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order(created_at: :desc)
        render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status:200
      end
    end
  end
  end