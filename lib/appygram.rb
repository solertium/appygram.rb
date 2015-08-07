require "appygram/version"
require 'net/http'
require 'net/https'
require 'json'

module Appygram
  def self.configure(params)
    if params[:api_key]
      Appygram::Config.api_key = params[:api_key]
    end
    if params[:topic]
      Appygram::Config.topic = params[:topic]
    end
    if params[:appygram_endpoint]
      appygram_endpoint = params[:appygram_endpoint]
      Appygram::Config.appygram_endpoint = URI appygram_endpoint
    end
    if params[:trace_endpoint]
      trace_endpoint = params[:trace_endpoint]
      Appygram::Config.trace_endpoint = URI trace_endpoint
    end
    # defaults if nothing is set
    Appygram::Config.appygram_endpoint ||= URI 'https://arecibo.appygram.com/appygrams'
    Appygram::Config.trace_endpoint ||= URI 'https://arecibo.appygram.com/traces'
    if params[:platform]
      Appygram::Config.platform = params[:platform] || 'web'
    end
    if params[:software]
      Appygram::Config.software = params[:software] || "appygram.rb #{Appygram::VERSION}"
    end
    # TODO: respect throttling per readme
  end

  def self.send(params)
    pc = params.clone
    pc[:api_key] = Appygram::Config.api_key
    pc[:topic] = Appygram::Config.topic unless pc[:topic]
    pc[:platform] = Appygram::Config.platform unless pc[:platform]
    pc[:software] = Appygram::Config.software unless pc[:software]
    if pc[:app_json]
      pc[:app_json] = JSON pc[:app_json]
    end
    url = Appygram::Config.appygram_endpoint
    req = Net::HTTP::Post.new url.request_uri
    req.form_data = pc
    session = Net::HTTP.new(url.host, url.port)
    if url.scheme == 'https'
      session.use_ssl = true
    end
    session.start {|http|
      http.request(req)
    }
  end

  def self.trace(exception, params = {})
    pc = params.clone
    pc[:api_key] = Appygram::Config.api_key
    pc[:topic] = Appygram::Config.topic unless pc[:topic]
    pc[:platform] = Appygram::Config.platform unless pc[:platform]
    pc[:software] = Appygram::Config.software unless pc[:software]
    if pc[:app_json]
      pc[:app_json] = JSON pc[:app_json]
    end
    url = Appygram::Config.trace_endpoint
    req = Net::HTTP::Post.new url.request_uri
    trace = []
    exception.backtrace.each do |line|
      trace << line.split(':')
    end
    pc[:trace] = JSON({
      'class' => exception.class.name,
      'message' => exception.message,
      'backtrace' => trace
    })
    req.form_data = pc
    session = Net::HTTP.new(url.host, url.port)
    if url.scheme == 'https'
      session.use_ssl = true
    end
    session.start {|http|
      http.request(req)
    }
  end

  class Config
    class << self
      attr_accessor :api_key, :topic, :appygram_endpoint, :trace_endpoint, :software, :platform
      def api_key
        return @api_key unless @api_key.nil?
      end
      def topic
        return @topic unless @topic.nil?
      end
      def appygram_endpoint
        return @appygram_endpoint unless @appygram_endpoint.nil?
      end
      def trace_endpoint
        return @trace_endpoint unless @trace_endpoint.nil?
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
