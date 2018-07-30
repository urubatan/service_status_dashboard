Rails.application.config.notification_address = ENV['notification_address'] || 'support@domain.test'
Rails.application.config.from_address = ENV['from_address']  || 'support@domain.test'