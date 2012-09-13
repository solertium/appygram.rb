require "appygram/version"
require 'net/http'
require 'net/https'

module Appygram
  def self.configure(params)
    Appygram::Config.api_key = params[:api_key]
    endpoint = params[:endpoint] || 'https://appygram.herokuapp.com/appygrams'
    Appygram::Config.endpoint = URI endpoint
    Appygram::Config.platform = params[:platform] || 'web'
    Appygram::Config.software = params[:software] || "appygram.rb #{Appygram::VERSION}"
  end

  def self.send(params)
    pc = params.clone
    pc[:api_key] = Appygram::Config.api_key
    pc[:platform] = Appygram::Config.platform unless pc[:platform]
    pc[:software] = Appygram::Config.software unless pc[:software]
    url = Appygram::Config.endpoint
    req = Net::HTTP::Post.new url.request_uri
    req.form_data = pc
    session = Net::HTTP.new(url.hostname, url.port)
    session.use_ssl = true
    session.start {|http|
      http.request(req)
    }
  end

  class Config
    class << self
      attr_accessor :api_key, :endpoint, :software, :platform
      def api_key
        return @api_key unless @api_key.nil?
      end
      def endpoint
        return @endpoint unless @endpoint.nil?
      end
      def software
        return @software unless @software.nil?
      end
      def platform
        return @platform unless @platform.nil?
      end
    end
  end

end
