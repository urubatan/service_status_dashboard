require 'net/http'
require 'json'

class Service < ApplicationRecord
  enum check_type: [:http_status, :match_string, :json]
  validates :name,:address, :check_type, presence: true
  validates :check_script, presence: true, unless: -> { self.http_status? } 


  def execute
    uri = URI(self.address)
    res = Net::HTTP.get_response(uri)
    result = case @service.check_type
    when :http_status
      res.is_a?(Net::HTTPSuccess)
    when :match_string
      res.body.strip == self.check_string if res.is_a?(Net::HTTPSuccess)
    when :json
      if res.is_a?(Net::HTTPSuccess)
        tpl = JSON.parse(self.check_string)
        res = JSON.parse(res.body)
        ok = true
        tpl.each do |k,v|
            ok = ok || res[k] == v
        end
        ok
      end
    end
    self.current_status = result
    self.current_text = result ? '' : res.body
    self.save
    self.save_history
  end

  def save_history
  end
end
