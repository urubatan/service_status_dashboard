require 'net/http'
require 'json'

class Service < ApplicationRecord
  enum check_type: [:http_status, :match_string, :json]
  has_many :service_histories   
  validates :name,:address, :check_type, presence: true
  validates :check_script, presence: true, unless: -> { self.http_status? } 


  def execute
    begin
      uri = URI(self.address)
      res = Net::HTTP.get_response(uri)
      result = case self.check_type
      when 'http_status'
        res.is_a?(Net::HTTPSuccess)
      when 'match_string'
        res.body.strip == self.check_script if res.is_a?(Net::HTTPSuccess)
      when 'json'
        if res.is_a?(Net::HTTPSuccess)
          tpl = JSON.parse(self.check_script)
          svc = JSON.parse(res.body)
          ok = true
          tpl.each do |k,v|
              ok = ok && svc[k] == v
          end
          ok
        else
          false
        end
      end
      self.current_status = result==true
      self.current_text = result ? '' : res.body
    rescue => e
      self.current_status = false
      self.current_text = e
    end
    self.save
    self.save_history
    self.current_status
  end

  def save_history
    unless self.current_status && self.service_histories.order('created_at desc').first.try(:status)
      self.service_histories.create status: self.current_status, status_text: self.current_text, notification_sent: false
    end
  end

  def last_failed
    self.service_histories.order('created_at asc').where('status = ?', false).first.try(:created_at) || 'Never'
  end

  def last_succeeded
    self.service_histories.order('created_at asc').where('status = ?', true).first.try(:created_at) || 'Never'
  end
end
