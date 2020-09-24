module Api
  module V1
    class ErrorsController < ApplicationController

      def not_found
        json_response({ message: 'Endpoint not found' }, status: 404)
      end

      def internal_server_error
        json_response({ message: 'Internal Server Error' }, status: 500)
      end
    end
  end
end
