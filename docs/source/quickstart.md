# Quickstart

## Dependencies

This library requires IP2Location BIN database to function. You may download the BIN database at

-   IP2Location LITE BIN Data (Free): <https://lite.ip2location.com>
-   IP2Location Commercial BIN Data (Comprehensive):
    <https://www.ip2location.com>

:::{note}
An outdated BIN database was provided in the rb/data folder for your testing. You are recommended to visit the above links to download the latest BIN database.
:::

## Installation

Install this package using the command as below:

```
gem install ip2location_ruby
```

## Sample Codes

### Query geolocation information from BIN database

You can query the geolocation information from the IP2Location BIN database as below:

```ruby
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
```

### Processing IP address using IP Tools class

You can manupulate IP address, IP number and CIDR as below:

```ruby
require 'ip2location_ruby'

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
```

### List down country information

You can query country information for a country from IP2Location Country Information CSV file as below:

```ruby
require 'ip2location_ruby'

# Country Class
country = Ip2locationCountry.new('./data/IP2LOCATION-COUNTRY-INFORMATION-BASIC.CSV')
puts country.get_country_info('US')
```

### List down region information

You can get the region code by country code and region name from IP2Location ISO 3166-2 Subdivision Code CSV file as below:

```ruby
require 'ip2location_ruby'

# Region Class
region = Ip2locationRegion.new('./data/IP2LOCATION-ISO3166-2.CSV')
puts region.get_region_code('US', 'California')
```