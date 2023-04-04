[![Latest Stable Version](https://img.shields.io/gem/v/ip2location_ruby.svg)](https://rubygems.org/gems/ip2location_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/ip2location_ruby.svg)](https://rubygems.org/gems/ip2location_ruby)

# IP2Location Ruby Library
This is IP2Location Ruby library that enables the user to find the country, region or state, district, city, latitude and longitude, ZIP/Postal code, time zone, Internet Service Provider (ISP) or company name, domain name, net speed, area code, weather station code, weather station name, mobile country code (MCC), mobile network code (MNC) and carrier brand, elevation, usage type, address type, IAB category and ASN from IP address using IP2Location database.  The library reads the geo location information from **IP2Location BIN data** file or web service.

Supported IPv4 and IPv6 address.

For more details, please visit:
[https://www.ip2location.com/developers/ruby](https://www.ip2location.com/developers/ruby)

# INSTALLATION
Install this package using the command as below:

```
gem install ip2location_ruby
```

# Usage
You can check the **example.rb** file to learn more about usage.

## BIN Database
An outdated BIN database was provided in the library for your testing. You are recommended to visit the [links](#dependencies) to download the latest BIN database and save it in the ```rb``` folder.

Below is the description of the functions available in the **BIN Database** lookup.

| Function Name | Description |
|---|---|
| open | Open the IP2Location BIN data for lookup. |
| close | Close and clean up the file pointer. |
| get_package_version | Get the package version (1 to 25 for DB1 to DB25 respectively). |
| get_module_version | Get the module version. |
| get_database_version | Get the database version. |
| get_last_error_message | Return the last error message. |
| get_all | Return the geolocation information in array. |
| get_country_short | Return the ISO3166-1 country code (2-digits) of the IP address. |
| get_country_long  | Return the ISO3166-1 country name of the IP address. |
| get_region | Return the ISO3166-2 region name of the IP address. Please visit [ISO3166-2 Subdivision Code](https://www.ip2location.com/free/iso3166-2) for the information of ISO3166-2 supported |
| get_city | Return the city name of the IP address. |
| get_latitude | Return the city latitude of the IP address. |
| get_longitude | Return the city longtitude of the IP address. |
| get_isp | Return the ISP name of the IP address. |
| get_domain | Return the domain name of IP address. |
| get_zipcode | Return the zipcode of the city. |
| get_timezone | Return the UTC time zone (with DST supported). |
| get_netspeed | Return the Internet connection type. |
| get_iddcode | Return the IDD prefix to call the city from another country. |
| get_areacode | Return the area code of the city. |
| get_weathercode | Return the nearest weather observation station code. |
| get_weathername | Return the nearest weather observation station name. |
| get_mcc | Return the Mobile Country Codes (MCC). |
| get_mnc | Return the Mobile Network Code (MNC). |
| get_mobilebrand | Commercial brand associated with the mobile carrier. |
| get_elevation | Return average height of city above sea level in meters (m). |
| get_usagetype | Return the ISP's usage type of IP address. |
| get_addresstype | Returns the IP address type (A-Anycast, B-Broadcast, M-Multicast & U-Unicast) of IP address or domain name. |
| get_category | Returns the IAB content taxonomy category of IP address or domain name. |
| get_district | Returns the district or county name of IP address. |
| get_asn | Returns the Autonomous system number (ASN) of IP address. |
| get_as | Returns the Autonomous system (AS) name of IP address. |

## Web Service
Below is the description of the functions available in the **Web Service** lookup.

| Function Name | Description |
|---|---|
| Constructor | Expect 3 input parameters:<ol><li>IP2Location API Key.</li><li>Package (WS1 - WS25)</li></li><li>Use HTTPS or HTTP</li></ol> |
| lookup | Return the IP information in array.<ul><li>country_code</li><li>country_name</li><li>region_name</li><li>city_name</li><li>latitude</li><li>longitude</li><li>zip_code</li><li>time_zone</li><li>isp</li><li>domain</li><li>net_speed</li><li>idd_code</li><li>area_code</li><li>weather_station_code</li><li>weather_station_name</li><li>mcc</li><li>mnc</li><li>mobile_brand</li><li>elevation</li><li>usage_type</li><li>address_type</li><li>category</li><li>continent<ul><li>name</li><li>code</li><li>hemisphere</li><li>translations</li></ul></li><li>country<ul><li>name</li><li>alpha3_code</li><li>numeric_code</li><li>demonym</li><li>flag</li><li>capital</li><li>total_area</li><li>population</li><li>currency<ul><li>code</li><li>name</li><li>symbol</li></ul></li><li>language<ul><li>code</li><li>name</li></ul></li><li>idd_code</li><li>tld</li><li>translations</li></ul></li><li>region<ul><li>name</li><li>code</li><li>translations</li></ul></li><li>city<ul><li>name</li><li>translations</li></ul></li><li>geotargeting<ul><li>metro</li></ul></li><li>country_groupings</li><li>time_zone_info<ul><li>olson</li><li>current_time</li><li>gmt_offset</li><li>is_dst</li><li>sunrise</li><li>sunset</li></ul></li><ul> |
| get_credit | Return remaining credit of the web service account. |

## IpTools
Below is the description of the functions available in the **IpTools** class.

| Function Name | Description |
|---|---|
| is_ipv4 | Return either true or false. Verify if a string is a valid IPv4 address. |
| is_ipv6 | Return either true or false. Verify if a string is a valid IPv6 address. |
| ipv4_to_decimal | Translate IPv4 address from dotted-decimal address to decimal format. Return null on error. |
| decimal_to_ipv4 | Translate IPv4 address from decimal number to dotted-decimal address. Return null on error. |
| ipv6_to_decimal | Translate IPv6 address from hexadecimal address to decimal format. Return null on error. |
| decimal_to_ipv6 | Translate IPv6 address from decimal number into hexadecimal address. Return null on error. |
| ipv4_to_cidr | Convert IPv4 range into a list of IPv4 CIDR notation. |
| cidr_to_ipv4 | Convert IPv4 CIDR notation into a list of IPv4 addresses. |
| ipv6_to_cidr | Convert IPv6 range into a list of IPv6 CIDR notation. |
| cidr_to_ipv6 | Convert IPv6 CIDR notation into a list of IPv6 addresses. |
| compress_ipv6 | Compress a IPv6 to shorten the length. |
| expand_ipv6 | Expand a shorten IPv6 to full length. |

## Country
Below is the description of the functions available in the **Country** class.

| Function Name | Description |
|---|---|
| Constructor | Expect a IP2Location Country Information CSV file. This database is free for download at https://www.ip2location.com/free/country-information |
| get_country_info | Provide a ISO 3166 country code to get the country information in array. Will return a full list of countries information if country code not provided. Below is the information returned: <ul><li>country_code</li><li>country_alpha3_code</li><li>country_numeric_code</li><li>capital</li><li>country_demonym</li><li>total_area</li><li>population</li><li>idd_code</li><li>currency_code</li><li>currency_name</li><li>currency_symbol</li><li>lang_code</li><li>lang_name</li><li>cctld</li></ul> |

## Region
Below is the description of the functions available in the **Region** class.

| Function Name | Description |
|---|---|
| Constructor | Expect a IP2Location ISO 3166-2 Subdivision Code CSV file. This database is free for download at https://www.ip2location.com/free/iso3166-2 |
| get_region_code | Provide a ISO 3166 country code and the region name to get ISO 3166-2 subdivision code for the region. |

# Dependencies
This library requires IP2Location BIN data file to function. You may download the BIN data file at
* IP2Location LITE BIN Data (Free): https://lite.ip2location.com
* IP2Location Commercial BIN Data (Comprehensive): https://www.ip2location.com

You can also sign up for [IP2Location Web Service](https://www.ip2location.com/web-service/ip2location) to lookup by IP2Location API.

# IPv4 BIN vs IPv6 BIN
* Use the IPv4 BIN file if you just need to query IPv4 addresses.
* Use the IPv6 BIN file if you need to query BOTH IPv4 and IPv6 addresses.

# Support

Email: support@ip2location.com  
URL: [https://www.ip2location.com](https://www.ip2location.com)
