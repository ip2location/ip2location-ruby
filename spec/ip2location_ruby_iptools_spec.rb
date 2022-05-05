require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2location" do
  it "work correctly with iptools is_ipv4" do
    iptool = Ip2locationIpTools.new()
    record = iptool.is_ipv4('8.8.8.8')
    expect(record).to eq true
  end

  it "work correctly with iptools invalid is_ipv4" do
    iptool = Ip2locationIpTools.new()
    record = iptool.is_ipv4('8.8.8.555')
    expect(record).to eq false
  end

  it "work correctly with iptools is_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.is_ipv6('2001:4860:4860::8888')
    expect(record).to eq true
  end

  it "work correctly with iptools invalid is_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.is_ipv6('2001:4860:4860::ZZZZ')
    expect(record).to eq false
  end

  it "work correctly with iptools ipv4_to_decimal" do
    iptool = Ip2locationIpTools.new()
    record = iptool.ipv4_to_decimal('8.8.8.8')
    expect(record).to eq 134744072
  end

  it "work correctly with iptools decimal_to_ipv4" do
    iptool = Ip2locationIpTools.new()
    record = iptool.decimal_to_ipv4(134744072)
    expect(record).to eq '8.8.8.8'
  end

  it "work correctly with iptools ipv6_to_decimal" do
    iptool = Ip2locationIpTools.new()
    record = iptool.ipv6_to_decimal('2001:4860:4860::8888')
    expect(record).to eq 42541956123769884636017138956568135816
  end

  it "work correctly with iptools decimal_to_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.decimal_to_ipv6(42541956123769884636017138956568135816)
    expect(record).to eq '2001:4860:4860::8888'
  end

  it "work correctly with iptools ipv4_to_cidr" do
    iptool = Ip2locationIpTools.new()
    record = iptool.ipv4_to_cidr('8.0.0.0', '8.255.255.255')
    expect(record).to eq ['8.0.0.0/8']
  end

  it "work correctly with iptools cidr_to_ipv4" do
    iptool = Ip2locationIpTools.new()
    record = iptool.cidr_to_ipv4('8.0.0.0/8')
    expect(record).to include(
  "ip_start"=>"8.0.0.0",
  "ip_end"=>"8.255.255.255"
)
  end

  it "work correctly with iptools ipv6_to_cidr" do
    iptool = Ip2locationIpTools.new()
    record = iptool.ipv6_to_cidr('2002:0000:0000:1234:abcd:ffff:c0a8:0000', '2002:0000:0000:1234:ffff:ffff:ffff:ffff')
    expect(record).to eq ['2002::1234:abcd:ffff:c0a8:0/109','2002::1234:abcd:ffff:c0b0:0/108','2002::1234:abcd:ffff:c0c0:0/106','2002::1234:abcd:ffff:c100:0/104','2002::1234:abcd:ffff:c200:0/103','2002::1234:abcd:ffff:c400:0/102','2002::1234:abcd:ffff:c800:0/101','2002::1234:abcd:ffff:d000:0/100','2002::1234:abcd:ffff:e000:0/99','2002:0:0:1234:abce::/79','2002:0:0:1234:abd0::/76','2002:0:0:1234:abe0::/75','2002:0:0:1234:ac00::/70','2002:0:0:1234:b000::/68','2002:0:0:1234:c000::/66']
  end

  it "work correctly with iptools cidr_to_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.cidr_to_ipv6('2002::1234:abcd:ffff:c0a8:101/64')
    expect(record).to include(
  "ip_start"=>"2002:0000:0000:1234:abcd:ffff:c0a8:0101",
  "ip_end"=>"2002:0000:0000:1234:ffff:ffff:ffff:ffff"
)
  end

  it "work correctly with iptools compress_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.compress_ipv6('2002:0000:0000:1234:ffff:ffff:ffff:ffff')
    expect(record).to eq '2002::1234:ffff:ffff:ffff:ffff'
  end

  it "work correctly with iptools expand_ipv6" do
    iptool = Ip2locationIpTools.new()
    record = iptool.expand_ipv6('2002::1234:ffff:ffff:ffff:ffff')
    expect(record).to eq '2002:0000:0000:1234:ffff:ffff:ffff:ffff'
  end

end
