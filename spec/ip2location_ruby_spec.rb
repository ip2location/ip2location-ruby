require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with ipv4" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP-COUNTRY-SAMPLE.bin")
    record = i2l.get_all('13.5.10.6')
    record.should_not be_nil
    record.country_short.should == 'US'
  end

  it "work correctly with ipv4 with new library" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/DB24.DEMO4.bin")
    record = i2l.get_all('13.5.10.6')
    record.should_not be_nil
    record.country_short.should == 'KR'
  end

  it "work correctly with ipv6 with new library" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/DB24.DEMO6.bin")
    record = i2l.get_all('2a01:04f8:0d16:26c2::')
    record.should_not be_nil
    record.country_short.should == 'DE'
  end

  # it "profile ipv6 in IPV6.BIN" do
  #   i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IPV6-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE.BIN")
  #   File.new(File.dirname(__FILE__) + "/assets/ipv6_ip.txt").readlines.each do |line|
  #     record = i2l.get_all(line.split(' ').first)
  #   end
  # end

  # it "profile ipv4 in IPV6.BIN" do
  #   i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IPV6-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE.BIN")
  #   File.new(File.dirname(__FILE__) + "/assets/ipv4_ip.txt").readlines.each do |line|
  #     record = i2l.get_all(line.split(' ').first)
  #   end
  # end

  # it "profile ipv4 in IPV4.BIN" do
  #   i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE.BIN")
  #   File.new(File.dirname(__FILE__) + "/assets/ipv4_ip.txt").readlines.each do |line|
  #     record = i2l.get_all(line.split(' ').first)
  #   end
  # end

  # this need spec/assets/IP2LOCATION-LITE-DB5.bin file which too big to include in this test.

  # it "should get float value of attitude" do
  #   i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB5.bin")
  #   record = i2l.get_all('192.110.164.88')
  #   record['latitude'].should eq(33.44837951660156)
  # end
end
