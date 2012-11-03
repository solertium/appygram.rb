require 'minitest/autorun'
require 'appygram'

describe Appygram do
  before do
    Appygram.configure :api_key => '6135441b70dc91c092fef59cb983f97eada68b75',
      :appygram_endpoint => 'https://appygram.herokuapp.com/appygrams',
      :trace_endpoint => 'https://appygram.appspot.com/traces'
  end
  describe "When connected to real servers" do
    it "sends appygrams" do
      Appygram.send :topic => 'Test', :message => 'This is a test.',
        :app_json => { 'key' => 'value' }
    end
    it "sends traces" do
      begin
        raise "boom"
      rescue StandardError => e
        Appygram.trace e
      end
    end
  end
end
