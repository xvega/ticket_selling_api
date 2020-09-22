module Api
  module V1
    class DummyController < ApplicationController
      def index
        render json: { message: "API DUMMY TEST" }
      end
    end
  end
end
