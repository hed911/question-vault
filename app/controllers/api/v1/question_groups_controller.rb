module Api
  module V1
    class QuestionGroupsController < ApplicationController
      def index
        records = QuestionGroup.all.order(created_at: :asc)
        render json: records.to_json(only: %i[id name status description])
      end

      def questions
        records = Question.where(question_group_id: params[:id]).order(created_at: :asc)
        render json: records.to_json(only: %i[id query answer status difficulty_level])
      end
    end
  end
end