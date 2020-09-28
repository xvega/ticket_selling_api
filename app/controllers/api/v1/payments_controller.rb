module Api
  module V1
    class PaymentsController < ApplicationController

      include Adapters::Payment

      def create
        begin
          gateway_charge = Gateway.charge(amount: payment_params[:amount],
                                          token: payment_params[:token])
          payment = Payment.new(amount: gateway_charge.amount,
                                currency: gateway_charge.currency,
                                ticket_id: payment_params[:ticket_id],
                                email: payment_params[:email] )
          if payment.save
            json_response(PaymentSerializer.new(payment), status: :created)
          else
            json_response(payment.errors.messages.to_json, status: :unprocessable_entity)
          end
        rescue => e
          json_response({ payment: e.message }, status: :unprocessable_entity)
        end
      end

      private

      def payment_params
        params.require(:payment).permit(:token, :currency, :amount, :ticket_id, :email)
      end
    end
  end
end
