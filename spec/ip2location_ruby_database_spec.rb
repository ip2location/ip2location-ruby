require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with ipv4" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_all('8.8.8.8')
    expect(record['country_short']).to eq 'US'
  end

  it "work correctly with get_country_short" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_country_short('8.8.8.8')
    expect(record).to eq 'US'
  end

  it "work correctly with get_country_long" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_country_long('8.8.8.8')
    expect(record).to eq 'United States of America'
  end

  it "work correctly with get_region" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_region('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_city" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_city('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_latitude" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_latitude('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_longitude" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_longitude('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_isp" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_isp('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_domain" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_domain('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_zipcode" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_zipcode('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_timezone" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_timezone('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_netspeed" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_netspeed('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_iddcode" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_iddcode('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_areacode" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_areacode('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_weatherstationcode" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_weatherstationcode('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_weatherstationname" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_weatherstationname('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_mcc" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_mcc('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_mnc" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_mnc('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_mobilebrand" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_mobilebrand('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_elevation" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_elevation('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_usagetype" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_usagetype('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_addresstype" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_addresstype('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with get_category" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_category('8.8.8.8')
    expect(record).to eq 'NOT SUPPORTED'
  end

  it "work correctly with ipv6" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_all('2001:4860:4860::8888')
    expect(record['country_short']).to eq 'US'
  end

  it "work correctly with ipv6 get_country_long" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_country_long('2001:4860:4860::8888')
    expect(record).to eq 'United States of America'
  end

  it "work correctly with ipv6 get_region" do
    i2l = Ip2location.new.open(File.dirname(__FILE__) + "/assets/IP2LOCATION-LITE-DB1.IPV6.BIN")
    record = i2l.get_region('2001:4860:4860::8888')
    expect(record).to eq 'NOT SUPPORTED'
  end
end
