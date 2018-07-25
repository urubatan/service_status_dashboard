class ServiceCheckSchedulerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Service.all.ids.each do |id|
      ServiceCheck.perform_async(id)
    end
  end
end
