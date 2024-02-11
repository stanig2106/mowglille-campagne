class EventsController < ApplicationController
  # export type Activity = {
  #   internalId: string
  #   name: string
  #   internalDescription: string
  #   description: string
  #   startDate: Date | null // null means the activity duration is the event duration
  #   endDate: Date | null
  #   location: string | null // null means the activity location is the event location
  #   activityRewards: ActivityReward[]
  # }
  def index
    render json: Event.all.map do |event|
      {
        internalId: event.internal_id,
        name: event.name,
        type: event.type,
        startDate: event.start_date.iso8601,
        endDate: event.end_date.iso8601,
        location: event.location,
        description: event.description,
        activities: event.activities.map do |activity|
          {
            internalId: activity.internal_id,
            name: activity.name,
            internalDescription: activity.internal_description,
            description: activity.description,
            startDate: activity.start_date&.iso8601,
            endDate: activity.end_date&.iso8601,
            location: activity.location,
            activityRewards: activity.activity_rewards.map do |activity_reward|
              {
                score: activity_reward.score,
                chest: activity_reward.chest,
                internalDescription: activity_reward.internal_description
              }
            end
          }
        end
      }
    end
  end

end
