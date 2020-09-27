module Api
  module V1
    class ReservationsController < ApplicationController

      before_action :authenticate!

      include Orderable
      include Pagination
      include Filterable

      def index
        reservations = filter_model(Reservation)
        json_response(ReservationSerializer.new(reservations), meta: pagination_meta(reservations))
      end

      def show
        reservation = Reservation.find_by(id: params[:id])
        json_response(ReservationSerializer.new(reservation), status: :ok)
      end

      def create
        reservation = Reservation.new(reservation_params)
        if reservation.valid?
          reservation.save
          json_response(ReservationSerializer.new(reservation), status: :created)
        else
          json_response(reservation.errors.messages.to_json, status: :unprocessable_entity)
        end
      end

      private

      def reservation_params
        params.require(:reservation).permit(:id,
                                            :selling_option,
                                            :email,
                                            :quantity,
                                            :ticket_id)
      end
    end
  end
end
