[![Latest Stable Version](https://img.shields.io/gem/v/ip2location_ruby.svg)](https://rubygems.org/gems/ip2location_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/ip2location_ruby.svg)](https://rubygems.org/gems/ip2location_ruby)

# IP2Location Ruby Library
This is IP2Location Ruby library that enables the user to find the country, region or state, city, latitude and longitude, US ZIP code, time zone, Internet Service Provider (ISP) or company name, domain name, net speed, area code, weather station code, weather station name, mobile country code (MCC), mobile network code (MNC) and carrier brand, elevation, and usage type by IP address or hostname originates from.  The library reads the geo location information
from **IP2Location BIN data** file.

Supported IPv4 and IPv6 address.

For more details, please visit:
[https://www.ip2location.com/developers/ruby](https://www.ip2location.com/developers/ruby)

# Usage

```
require 'ip2location_ruby'

i2l = Ip2location.new.open("./data/IPV6-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE.BIN")
record = i2l.get_all('8.8.8.8')

print 'Country Code: ' + record['country_short'] + "\n"
print 'Country Name: ' + record['country_long'] + "\n"
print 'Region Name: ' + record['region'] + "\n"
print 'City Name: ' + record['city'] + "\n"
print 'Latitude: '
print record['latitude']
print "\n"
print 'Longitude: '
print record['longitude']
print "\n"
print 'ISP: ' + record['isp'] + "\n"
print 'Domain: ' + record['domain'] + "\n"
print 'Net Speed: ' + record['netspeed'] + "\n"
print 'Area Code: ' + record['areacode'] + "\n"
print 'IDD Code: ' + record['iddcode'] + "\n"
print 'Time Zone: ' + record['timezone'] + "\n"
print 'ZIP Code: ' + record['zipcode'] + "\n"
print 'Weather Station Code: ' + record['weatherstationname'] + "\n"
print 'Weather Station Name: ' + record['weatherstationcode'] + "\n"
print 'MCC: ' + record['mcc'] + "\n"
print 'MNC: ' + record['mnc'] + "\n"
print 'Mobile Name: ' + record['mobilebrand'] + "\n"
print 'Elevation: '
print record['elevation']
print "\n"
print 'Usage Type: ' + record['usagetype'] + "\n"

i2l.close()
```

# Sample BIN Databases

* Download free IP2Location LITE databases at [https://lite.ip2location.com](https://lite.ip2location.com)  
* Download IP2Location sample databases at [https://www.ip2location.com/developers](https://www.ip2location.com/developers)

# IPv4 BIN vs IPv6 BIN

* Use the IPv4 BIN file if you just need to query IPv4 addresses.
* Use the IPv6 BIN file if you need to query BOTH IPv4 and IPv6 addresses.

# Support

Email: support@ip2location.com  
URL: [https://www.ip2location.com](https://www.ip2location.com)
