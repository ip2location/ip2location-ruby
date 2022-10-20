require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with country get_country_info field" do
    country = Ip2locationCountry.new('./data/IP2LOCATION-COUNTRY-INFORMATION-BASIC.CSV')
    record = country.get_country_info('US')
    expect(record).to include("country_code")
  end

  it "work correctly with country get_country_info value" do
    country = Ip2locationCountry.new('./data/IP2LOCATION-COUNTRY-INFORMATION-BASIC.CSV')
    record = country.get_country_info('US')
    expect(record["country_code"]).to eq 'US'
  end

  it "work correctly with country get_country_info capital" do
    country = Ip2locationCountry.new('./data/IP2LOCATION-COUNTRY-INFORMATION-BASIC.CSV')
    record = country.get_country_info('MY')
    expect(record["capital"]).to eq 'Kuala Lumpur'
  end
end
