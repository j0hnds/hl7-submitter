require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe CmdlineOptions do
  let(:cmd_options) { CmdlineOptions.new }

  describe "Option Defaults" do

    before(:each) do
      cmd_options.parse!([])
    end

    it "should have verbose turned off" do
      expect(cmd_options.verbose?).to be_falsey
    end

    it "should have basic_auth turned off" do
      expect(cmd_options.basic_auth?).to be_falsey
    end

    it "should have run turned on" do
      expect(cmd_options.run?).to be_truthy
    end

    it "should have a default host of 'localhost'" do
      expect(cmd_options.host).to eq('localhost')
    end

    it "should have a default port of 20440" do
      expect(cmd_options.port).to eq(20440)
    end

    it "should have a default username of 'pcc'" do
      expect(cmd_options.username).to eq('pcc')
    end

    it "should have a default password of 'Splatter'" do
      expect(cmd_options.password).to eq('Splatter')
    end

    it "should always return some hl7 data" do
      expect(cmd_options.hl7_data).not_to be_empty
    end

  end

  describe "Short options" do
    before(:each) do
      cmd_options.parse!([ "-a", 
                          "-h", "www.thing.com", 
                          "-f", "Gemfile", 
                          "-n",
                          "-p", "2301",
                          "-u", "myuser",
                          "-v"]) 

    end

    it "should have verbose turned on" do
      expect(cmd_options.verbose?).to be_truthy
    end

    it "should have basic_auth turned on" do
      expect(cmd_options.basic_auth?).to be_truthy
    end

    it "should have run turned off" do
      expect(cmd_options.run?).to be_falsey
    end

    it "should have a host of 'www.thing.com'" do
      expect(cmd_options.host).to eq('www.thing.com')
    end

    it "should have a port of 2301" do
      expect(cmd_options.port).to eq(2301)
    end

    it "should have a username of 'myuser'" do
      expect(cmd_options.username).to eq('myuser')
    end

    it "should always return some hl7 data" do
      expect(cmd_options.hl7_data).not_to be_empty
    end

  end

  describe "Long options" do
    before(:each) do
      cmd_options.parse!([ "-auth", 
                          "--host", "www.thing.com", 
                          "--file", "Gemfile", 
                          "--no-run",
                          "--port", "2301",
                          "--password", "mypass",
                          "--username", "myuser",
                          "--verbose"]) 

    end

    it "should have verbose turned on" do
      expect(cmd_options.verbose?).to be_truthy
    end

    it "should have basic_auth turned on" do
      expect(cmd_options.basic_auth?).to be_truthy
    end

    it "should have run turned off" do
      expect(cmd_options.run?).to be_falsey
    end

    it "should have a host of 'www.thing.com'" do
      expect(cmd_options.host).to eq('www.thing.com')
    end

    it "should have a port of 2301" do
      expect(cmd_options.port).to eq(2301)
    end

    it "should have a username of 'myuser'" do
      expect(cmd_options.username).to eq('myuser')
    end

    it "should have a password of 'mypass'" do
      expect(cmd_options.password).to eq('mypass')
    end

    it "should always return some hl7 data" do
      expect(cmd_options.hl7_data).not_to be_empty
    end

  end
end
