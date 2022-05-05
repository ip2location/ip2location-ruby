require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with web service lookup" do
    ws = Ip2locationWebService.new('demo', 'WS25', true)
    record = ws.lookup('8.8.8.8', '', 'en')
    expect(record['country_code']).to eq 'US'
  end

  it "work correctly with web service get_credit" do
    ws = Ip2locationWebService.new('demo', 'WS25', true)
    record = ws.get_credit()
    expect(record).to eq 0
  end
end
