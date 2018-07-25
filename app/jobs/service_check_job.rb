class ServiceCheckJob < ApplicationJob
  queue_as :default

  def perform(id)
    @service = Service.find id
    @service.execute
  end
end
