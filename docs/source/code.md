# IP2Location Ruby API

## Ip2location Class

```{py:function} open(database_file_path)
Load the IP2Location BIN database.

:param str database_file_path: (Required) The file path links to IP2Location BIN databases.
```

```{py:function} get_package_version()
Get the package version (1 to 25 for DB1 to DB25 respectively).

:return: Returns the package version.
:rtype: string
```

```{py:function} get_module_version()
Get the module version.

:return: Returns the module version.
:rtype: string
```

```{py:function} get_database_version()
Get the database version.

:return: Returns the database version.
:rtype: string
```

```{py:function} get_all(ip_address)
Retrieve geolocation information for an IP address.

:param str ip_address: (Required) The IP address (IPv4 or IPv6).
:return: Returns the geolocation information in array. Refer below table for the fields avaliable in the array
:rtype: array

**RETURN FIELDS**

| Field Name       | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| country_short    |     Two-character country code based on ISO 3166. |
| country_long     |     Country name based on ISO 3166. |
| region           |     Region or state name. |
| city             |     City name. |
| isp              |     Internet Service Provider or company\'s name. |
| latitude         |     City latitude. Defaults to capital city latitude if city is unknown. |
| longitude        |     City longitude. Defaults to capital city longitude if city is unknown. |
| domain           |     Internet domain name associated with IP address range. |
| zipcode          |     ZIP code or Postal code. [172 countries supported](https://www.ip2location.com/zip-code-coverage). |
| timezone         |     UTC time zone (with DST supported). |
| netspeed         |     Internet connection type. |
| idd_code         |     The IDD prefix to call the city from another country. |
| area_code        |     A varying length number assigned to geographic areas for calls between cities. [223 countries supported](https://www.ip2location.com/area-code-coverage). |
| weather_code     |     The special code to identify the nearest weather observation station. |
| weather_name     |     The name of the nearest weather observation station. |
| mcc              |     Mobile Country Codes (MCC) as defined in ITU E.212 for use in identifying mobile stations in wireless telephone networks, particularly GSM and UMTS networks. |
| mnc              |     Mobile Network Code (MNC) is used in combination with a Mobile Country Code(MCC) to uniquely identify a mobile phone operator or carrier. |
| mobile_brand     |     Commercial brand associated with the mobile carrier. You may click [mobile carrier coverage](https://www.ip2location.com/mobile-carrier-coverage) to view the coverage report. |
| elevation        |     Average height of city above sea level in meters (m). |
| usage_type       |     Usage type classification of ISP or company. |
| address_type     |     IP address types as defined in Internet Protocol version 4 (IPv4) and Internet Protocol version 6 (IPv6). |
| category         |     The domain category based on [IAB Tech Lab Content Taxonomy](https://www.ip2location.com/free/iab-categories). |
| district         |     District or county name. |
| asn              |     Autonomous system number (ASN). BIN databases. |
| as_name          |     Autonomous system (AS) name. |
```

## Ip2locationIpTools Class

```{py:class} Ip2locationIpTools()
Initiate Ip2locationIpTools class.
```

```{py:function} is_ipv4(ip_address)
Verify if a string is a valid IPv4 address.

:param str ip_address: (Required) IP address.
:return: Return True if the IP address is a valid IPv4 address or False if it isn't a valid IPv4 address.
:rtype: boolean
```

```{py:function} is_ipv6(ip_address)
Verify if a string is a valid IPv6 address

:param str ip_address: (Required) IP address.
:return: Return True if the IP address is a valid IPv6 address or False if it isn't a valid IPv6 address.
:rtype: boolean
```

```{py:function} ipv4_to_decimal(ip_address)
Translate IPv4 address from dotted-decimal address to decimal format.

:param str ip_address: (Required) IPv4 address.
:return: Return the decimal format of the IPv4 address.
:rtype: int
```

```{py:function} decimal_to_ipv4(ip_number)
Translate IPv4 address from decimal number to dotted-decimal address.

:param str ip_number: (Required) Decimal format of the IPv4 address.
:return: Returns the dotted-decimal format of the IPv4 address.
:rtype: string
```

```{py:function} ipv6_to_decimal(ip_address)
Translate IPv6 address from hexadecimal address to decimal format.

:param str ip_address: (Required) IPv6 address.
:return: Return the decimal format of the IPv6 address.
:rtype: int
```

```{py:function} decimal_to_ipv6(ip_number)
Translate IPv6 address from decimal number into hexadecimal address.

:param str ip_number: (Required) Decimal format of the IPv6 address.
:return: Returns the hexadecimal format of the IPv6 address.
:rtype: string
```

```{py:function} ipv4_to_cidr(ip_from, ip_to)
Convert IPv4 range into a list of IPv4 CIDR notation.

:param str ip_from: (Required) The starting IPv4 address in the range.
:param str ip_to: (Required) The ending IPv4 address in the range.
:return: Returns the list of IPv4 CIDR notation.
:rtype: array
```

```{py:function} cidr_to_ipv4(cidr)
Convert IPv4 CIDR notation into a list of IPv4 addresses.

:param str cidr: (Required) IPv4 CIDR notation.
:return: Returns an list of IPv4 addresses.
:rtype: array
```

```{py:function} ipv6_to_cidr(ip_from, ip_to)
Convert IPv6 range into a list of IPv6 CIDR notation.

:param str ip_from: (Required) The starting IPv6 address in the range.
:param str ip_to: (Required) The ending IPv6 address in the range.
:return: Returns the list of IPv6 CIDR notation.
:rtype: array
```

```{py:function} cidr_to_ipv6(cidr)
Convert IPv6 CIDR notation into a list of IPv6 addresses.

:param str cidr: (Required) IPv6 CIDR notation.
:return: Returns an list of IPv6 addresses.
:rtype: array
```


```{py:function} compress_ipv6(ip_address)
Compress a IPv6 to shorten the length.

:param str ip_address: (Required) IPv6 address.
:return: Returns the compressed version of IPv6 address.
:rtype: str
```

```{py:function} expand_ipv6(ip_address)
Expand a shorten IPv6 to full length.

:param str ip_address: (Required) IPv6 address.
:return: Returns the extended version of IPv6 address.
:rtype: str
```

## Ip2locationCountry Class

```{py:class} Ip2locationCountry(csv_file_path)
Initiate Ip2locationCountry class and load the IP2Location Country Information CSV file. This database is free for download at <https://www.ip2location.com/free/country-information>.

:param str csv_file_path: (Required) The file path links to IP2Location Country Information CSV file.
```

```{py:function} get_country_info(country_code)
Provide a ISO 3166 country code to get the country information in array. Will return a full list of countries information if country code not provided. 

:param str country_code: (Required) The ISO 3166 country code of a country.
:return: Returns the country information in array. Refer below table for the fields avaliable in the array.
:rtype: array

**RETURN FIELDS**

| Field Name       | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| country_code     | Two-character country code based on ISO 3166.                |
| country_alpha3_code | Three-character country code based on ISO 3166.           |
| country_numeric_code | Three-character country code based on ISO 3166.          |
| capital          | Capital of the country.                                      |
| country_demonym  | Demonym of the country.                                      |
| total_area       | Total area in km{sup}`2`.                                    |
| population       | Population of year 2014.                                     |
| idd_code         | The IDD prefix to call the city from another country.        |
| currency_code    | Currency code based on ISO 4217.                             |
| currency_name    | Currency name.                                               |
| currency_symbol  | Currency symbol.                                             |
| lang_code        | Language code based on ISO 639.                              |
| lang_name        | Language name.                                               |
| cctld            | Country-Code Top-Level Domain.                               |
```

## Ip2locationRegion Class

```{py:class} Ip2locationRegion(csv_file_path)
Initiate Ip2locationRegion class and load the IP2Location ISO 3166-2 Subdivision Code CSV file. This database is free for download at <https://www.ip2location.com/free/iso3166-2>

:param str csv_file_path: (Required) The file path links to IP2Location ISO 3166-2 Subdivision Code CSV file.
```

```{py:function} get_region_code(country_code, region_name)
Provide a ISO 3166 country code and the region name to get ISO 3166-2 subdivision code for the region.

:param str country_code: (Required) Two-character country code based on ISO 3166.
:param str region_name: (Required) Region or state name.
:return: Returns the ISO 3166-2 subdivision code of the region.
:rtype: str
```