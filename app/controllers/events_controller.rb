class EventsController < ApplicationController
  def index
    render json: Event.all.map do |event|
      {
        internal_id: event.internal_id,
        name: event.name,
        type: event.type,
        start_date: event.start_date.iso8601,
        end_date: event.end_date.iso8601,
        location: event.location,
        description: event.description,
      }
    end
  end

end
