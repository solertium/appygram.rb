require 'minitest/autorun'
require 'appygram'

describe Appygram do
  describe "when invoking the gem" do
    it "must have a version number" do
      Appygram::VERSION.wont_be_nil
    end
  end
  describe "when configuring" do
    it "must support setting the API key" do
      Appygram.configure :api_key => '123'
      Appygram::Config.api_key.must_equal '123'
    end
    it "must support setting the platform" do
      Appygram.configure :platform => 'test_plat'
      Appygram::Config.platform.must_equal 'test_plat'
    end
    it "must support setting the software" do
      Appygram.configure :software => 'test_sw'
      Appygram::Config.software.must_equal 'test_sw'
    end
    it "must support overriding the appygram endpoint" do
      Appygram.configure :appygram_endpoint => 'http://a/b'
      Appygram::Config.appygram_endpoint.to_s.must_equal 'http://a/b'
    end
    it "must support overriding the trace endpoint" do
      Appygram.configure :trace_endpoint => 'http://a/b'
      Appygram::Config.trace_endpoint.to_s.must_equal 'http://a/b'
    end
    it "must not clobber values set earlier" do
      Appygram::Config.platform.must_equal 'test_plat'
    end
  end
end
