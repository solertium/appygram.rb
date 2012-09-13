require "appygram/version"
require 'net/http'

module Appygram
  def self.configure(api_key)
    Appygram::Config.api_key = api_key
  end
  def self.send(params)
    http = Net::HTTP.post_form(URI.parse('https://appygram.herokuapp.com/appygrams', params)
  end

  class Config
    class << self
      attr_accessor :api_key
      def api_key
        return @api_key unless @api_key.nil?
      end
    end
  end

end
