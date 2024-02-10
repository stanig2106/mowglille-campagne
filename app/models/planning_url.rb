class PlanningUrl < ApplicationRecord
  def self.get
    last&.url || ''
  end

  def self.set(url)
    destroy_all
    create(url:)
  end
end
