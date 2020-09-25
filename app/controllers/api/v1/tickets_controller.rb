module Api
  module V1
    class TicketsController < ApplicationController

      before_action :authenticate!

      include Orderable
      include Pagination
      include Filterable

      def index
        tickets = filter_model(Ticket)
        json_response(tickets, meta: pagination_meta(tickets))
      end

      def create
        ticket = Ticket.new(ticket_params)
        if ticket.save
          render json: TicketSerializer.new(ticket), status: 201
        else
          json_response(ticket.errors.messages.to_json, status: 422)
        end
      end

      private

      def ticket_params
        params.require(:ticket).permit(:id,
                                       :name,
                                       :quantity,
                                       :description,
                                       :status,
                                       :price,
                                       :event_id)
      end
    end
  end
end
