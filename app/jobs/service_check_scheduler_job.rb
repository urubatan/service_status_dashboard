class ServiceCheckSchedulerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Service.all.ids.each do |id|
      ServiceCheckJob.perform_later(id)
    end
  end
end
