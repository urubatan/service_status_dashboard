require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
  #config.redis = { :namespace => 'Publishapp', :url => "redis://#{ENV['REDIS_HOST'] || 'solrdevdb'}:6379/" }
end

Sidekiq.configure_server do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  #config.redis = { :namespace => 'Publishapp', :url => "redis://#{ENV['REDIS_HOST'] || 'solrdevdb'}:6379/" }
end
Rails.application.config.active_job.queue_adapter = :sidekiq

schedule_file = "config/schedule.yml"

if File.exists?(Rails.root.join(schedule_file)) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash! YAML.load_file(Rails.root.join(schedule_file))
end