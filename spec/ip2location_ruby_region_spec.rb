require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with region get_region_code value" do
    region = Ip2locationRegion.new('./data/IP2LOCATION-ISO3166-2.CSV')
    record = region.get_region_code('US', 'California')
    expect(record).to eq 'US-CA'
  end
end
