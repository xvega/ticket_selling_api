module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        reservation = Reservation.new(reservation_params)
        if reservation.valid?
            reservation.save
          json_response(reservation, status: :created)
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
