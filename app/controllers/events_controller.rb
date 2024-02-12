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
    render json: (Event.all.map do |event|
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
                id: activity_reward.id,
                name: activity_reward.name,
                score: activity_reward.score,
                chest: activity_reward.chest,
                internalDescription: activity_reward.internal_description
              }
            end
          }
        end
      }
    end)

  end

  def update # update event, activity, and activity_reward
    event = Event.find_by(internal_id: params[:internal_id])
    event.update!({
                    name: params[:name],
                    location: params[:location],
                    description: params[:description],
                  })
    params[:activities].each do |a|
      activity = Activity.find_or_initialize_by(internal_id: a[:internalId])
      activity.update!({
                         name: a[:name],
                         internal_description: a[:internalDescription],
                         description: a[:description],
                         start_date: a[:startDate],
                         end_date: a[:endDate],
                         location: a[:location],
                         event:
                       })
      a[:activityRewards].each do |ar|
        activity_reward = ActivityReward.find_by(id: ar[:id]) || ActivityReward.new
        activity_reward.update!({
                                  name: ar[:name],
                                  score: ar[:score],
                                  chest: ar[:chest],
                                  internal_description: ar[:internalDescription],
                                  activity:
                                })
      end
    end
    params[:removedActivities]&.each do |a|
      Activity.find_by(internal_id: a[:internalId]).destroy
    end
    params[:removedActivityRewards]&.each do |ar|
      ActivityReward.find_by(id: ar[:id]).destroy
    end
  end
end
