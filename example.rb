require 'ip2location_ruby'

# BIN Database
i2l = Ip2location.new.open("./data/IP2LOCATION-LITE-DB1.IPV6.BIN")
record = i2l.get_all('8.8.8.8')

puts 'Country Code: ' + record['country_short']
puts 'Country Name: ' + record['country_long']
puts 'Region Name: ' + record['region']
puts 'City Name: ' + record['city']
puts 'Latitude: '
puts record['latitude']
puts 'Longitude: '
puts record['longitude']
puts 'ISP: ' + record['isp']
puts 'Domain: ' + record['domain']
puts 'Net Speed: ' + record['netspeed']
puts 'Area Code: ' + record['areacode']
puts 'IDD Code: ' + record['iddcode']
puts 'Time Zone: ' + record['timezone']
puts 'ZIP Code: ' + record['zipcode']
puts 'Weather Station Code: ' + record['weatherstationname']
puts 'Weather Station Name: ' + record['weatherstationcode']
puts 'MCC: ' + record['mcc']
puts 'MNC: ' + record['mnc']
puts 'Mobile Name: ' + record['mobilebrand']
puts 'Elevation: '
puts record['elevation']
puts 'Usage Type: ' + record['usagetype']
puts 'Address Type: ' + record['addresstype']
puts 'Category: ' + record['category']
puts 'District: ' + record['district']
puts 'ASN: ' + record['asn']
puts 'AS: ' + record['as']
i2l.close()

# IP Tools
iptool = Ip2locationIpTools.new()
puts iptool.is_ipv4('8.8.8.8')
puts iptool.is_ipv6('2001:4860:4860::8888')
puts iptool.ipv4_to_decimal('8.8.8.8')
puts iptool.decimal_to_ipv4(134744072)
puts iptool.ipv6_to_decimal('2001:4860:4860::8888')
puts iptool.decimal_to_ipv6(42541956123769884636017138956568135816)
puts iptool.ipv4_to_cidr('8.0.0.0', '8.255.255.255')
puts iptool.cidr_to_ipv4('8.0.0.0/8')
puts iptool.ipv6_to_cidr('2002:0000:0000:1234:abcd:ffff:c0a8:0000', '2002:0000:0000:1234:ffff:ffff:ffff:ffff')
puts iptool.cidr_to_ipv6('2002::1234:abcd:ffff:c0a8:101/64')
puts iptool.compress_ipv6('2002:0000:0000:1234:ffff:ffff:ffff:ffff')
puts iptool.expand_ipv6('2002::1234:ffff:ffff:ffff:ffff')

# Country Class
country = Ip2locationCountry.new('./data/IP2LOCATION-COUNTRY-INFORMATION-BASIC.CSV')
puts country.get_country_info('US')

# Region Class
region = Ip2locationRegion.new('./data/IP2LOCATION-ISO3166-2.CSV')
puts region.get_region_code('US', 'California')
