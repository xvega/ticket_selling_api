module Api
  module V1
    class TicketsController < ApplicationController

      before_action :authenticate!

      include Orderable
      include Pagination
      include Filterable

      def index
        tickets = filter_model(Ticket)
        json_response(TicketSerializer.new(tickets), meta: pagination_meta(tickets))
      end

      def show
        # this will filter by events not by ticket
        tickets = Ticket.by_event(params[:id])
        json_response(TicketSerializer.new(tickets), status: :ok)
      end

      def create
        ticket = Ticket.new(ticket_params)
        if ticket.save
          json_response(TicketSerializer.new(ticket), status: :created)
        else
          json_response(ticket.errors.messages.to_json, status: :unprocessable_entity)
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
