module Api
  module V1
    class EventsController < ApplicationController

      before_action :authenticate!

      include Orderable
      include Pagination
      include Filterable

      def index
        events = filter_model(Event)
        json_response(EventSerializer.new(events), meta: pagination_meta(events))
      end

      def show
        event = Event.find(params[:id])
        json_response(EventSerializer.new(event), status: :ok)
      end

      def create
        event = Event.new(event_params)
        if event.save
          json_response(EventSerializer.new(event), status: :created)
        else
          json_response(event.errors.messages.to_json, status: :unprocessable_entity)
        end
      end

      private

      def event_params
        params.require(:event).permit(:id, :name, :description, :date, :time)
      end
    end
  end
end
