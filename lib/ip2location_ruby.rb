# encoding: utf-8
require 'bindata'
require 'ipaddr'
require 'net/http'
require 'json'
require 'ip2location_ruby/ip2location_config'
require 'ip2location_ruby/database_config'
require 'ip2location_ruby/i2l_float_data'
require 'ip2location_ruby/i2l_string_data'
require 'ip2location_ruby/i2l_ip_data'
require 'ip2location_ruby/ip2location_record'

class Ip2location
  attr_accessor :record_class4, :record_class6, :v4, :file, :db_index, :count, :base_addr, :ipno, :count, :record, :database, :columns, :ip_version, :ipv4databasecount, :ipv4databaseaddr, :ipv4indexbaseaddr, :ipv6databasecount, :ipv6databaseaddr, :ipv6indexbaseaddr

  FIELD_NOT_SUPPORTED = 'NOT SUPPORTED'
  INVALID_IP_ADDRESS = 'INVALID IP ADDRESS'

  def open(url)
    self.file = File.open(File.expand_path url, 'rb')
    i2l = Ip2locationConfig.read(file)
    self.db_index = i2l.databasetype
    self.columns = i2l.databasecolumn + 0
    self.database = DbConfig.setup_database(self.db_index)
    self.ipv4databasecount = i2l.ipv4databasecount
    self.ipv4databaseaddr = i2l.ipv4databaseaddr
    self.ipv6databasecount = i2l.ipv6databasecount
    self.ipv6databaseaddr = i2l.ipv6databaseaddr
    self.ipv4indexbaseaddr = i2l.ipv4indexbaseaddr
    self.ipv6indexbaseaddr = i2l.ipv6indexbaseaddr
    self.record_class4 = (Ip2LocationRecord.init database, 4)
    self.record_class6 = (Ip2LocationRecord.init database, 6)
    self
  end

  def close()
    self.file.close
  end

  def get_record(ip)
    ipno = IPAddr.new(ip, Socket::AF_UNSPEC)
    self.ip_version, ipnum = validateip(ipno)
    self.v4 = ip_version == 4 ? true : false
    self.count = v4 ? self.ipv4databasecount + 0 : self.ipv6databasecount + 0
    self.base_addr = (v4 ? self.ipv4databaseaddr - 1 : self.ipv6databaseaddr - 1)
    col_length = columns * 4
    if ipv4indexbaseaddr > 0 || ipv6indexbaseaddr > 0
        indexpos = 0
        case ip_version
        when 4
            indexpos = ipv4indexbaseaddr + ((ipnum >> 16) << 3)
            realipno = ipnum
            # if ipnum reach MAX_IPV4_RANGE
            if realipno == 4294967295
                ipnum = realipno - 1
            end
        when 6
            indexpos = ipv6indexbaseaddr + ((ipnum >> 112) << 3)
            realipno = ipnum
            # if ipnum reach MAX_IPV6_RANGE
            if realipno == 340282366920938463463374607431768211455
                ipnum = realipno - 1
            end
        end
        low = read32(indexpos)
        high = read32(indexpos + 4)
        return self.record = bsearch(low, high, ipnum, self.base_addr, col_length)
    else
        return self.record = bsearch(0, self.count, ipnum, self.base_addr, col_length)
    end
  end

  def get_all(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_short = (defined?(rec.country_short) && rec.country_short != '') ? rec.country_short : FIELD_NOT_SUPPORTED
            country_long = (defined?(rec.country_long) && rec.country_long != '') ? rec.country_long : FIELD_NOT_SUPPORTED
            region = (defined?(rec.region) && rec.region != '') ? rec.region : FIELD_NOT_SUPPORTED
            city = (defined?(rec.city) && rec.city != '') ? rec.city : FIELD_NOT_SUPPORTED
            latitude = (defined?(rec.latitude) && rec.latitude != '') ? rec.latitude : FIELD_NOT_SUPPORTED
            longitude = (defined?(rec.longitude) && rec.longitude != '') ? rec.longitude : FIELD_NOT_SUPPORTED
            isp = (defined?(rec.isp) && rec.isp != '') ? rec.isp : FIELD_NOT_SUPPORTED
            domain = (defined?(rec.domain) && rec.domain != '') ? rec.domain : FIELD_NOT_SUPPORTED
            netspeed = (defined?(rec.netspeed) && rec.netspeed != '') ? rec.netspeed : FIELD_NOT_SUPPORTED
            areacode = (defined?(rec.areacode) && rec.areacode != '') ? rec.areacode : FIELD_NOT_SUPPORTED
            iddcode = (defined?(rec.iddcode) && rec.iddcode != '') ? rec.iddcode : FIELD_NOT_SUPPORTED
            timezone = (defined?(rec.timezone) && rec.timezone != '') ? rec.timezone : FIELD_NOT_SUPPORTED
            zipcode = (defined?(rec.zipcode) && rec.zipcode != '') ? rec.zipcode : FIELD_NOT_SUPPORTED
            weatherstationname = (defined?(rec.weatherstationname) && rec.weatherstationname != '') ? rec.weatherstationname : FIELD_NOT_SUPPORTED
            weatherstationcode = (defined?(rec.weatherstationcode) && rec.weatherstationcode != '') ? rec.weatherstationcode : FIELD_NOT_SUPPORTED
            mcc = (defined?(rec.mcc) && rec.mcc != '') ? rec.mcc : FIELD_NOT_SUPPORTED
            mnc = (defined?(rec.mnc) && rec.mnc != '') ? rec.mnc : FIELD_NOT_SUPPORTED
            mobilebrand = (defined?(rec.mobilebrand) && rec.mobilebrand != '') ? rec.mobilebrand : FIELD_NOT_SUPPORTED
            elevation = (defined?(rec.elevation) && rec.elevation != '') ? rec.elevation : FIELD_NOT_SUPPORTED
            usagetype = (defined?(rec.usagetype) && rec.usagetype != '') ? rec.usagetype : FIELD_NOT_SUPPORTED
        else
            country_short = INVALID_IP_ADDRESS
            country_long = INVALID_IP_ADDRESS
            region = INVALID_IP_ADDRESS
            city = INVALID_IP_ADDRESS
            latitude = INVALID_IP_ADDRESS
            longitude = INVALID_IP_ADDRESS
            isp = INVALID_IP_ADDRESS
            domain = INVALID_IP_ADDRESS
            netspeed = INVALID_IP_ADDRESS
            areacode = INVALID_IP_ADDRESS
            iddcode = INVALID_IP_ADDRESS
            timezone = INVALID_IP_ADDRESS
            zipcode = INVALID_IP_ADDRESS
            weatherstationname = INVALID_IP_ADDRESS
            weatherstationcode = INVALID_IP_ADDRESS
            mcc = INVALID_IP_ADDRESS
            mnc = INVALID_IP_ADDRESS
            mobilebrand = INVALID_IP_ADDRESS
            elevation = INVALID_IP_ADDRESS
            usagetype = INVALID_IP_ADDRESS
        end
    else
        country_short = INVALID_IP_ADDRESS
        country_long = INVALID_IP_ADDRESS
        region = INVALID_IP_ADDRESS
        city = INVALID_IP_ADDRESS
        latitude = INVALID_IP_ADDRESS
        longitude = INVALID_IP_ADDRESS
        isp = INVALID_IP_ADDRESS
        domain = INVALID_IP_ADDRESS
        netspeed = INVALID_IP_ADDRESS
        areacode = INVALID_IP_ADDRESS
        iddcode = INVALID_IP_ADDRESS
        timezone = INVALID_IP_ADDRESS
        zipcode = INVALID_IP_ADDRESS
        weatherstationname = INVALID_IP_ADDRESS
        weatherstationcode = INVALID_IP_ADDRESS
        mcc = INVALID_IP_ADDRESS
        mnc = INVALID_IP_ADDRESS
        mobilebrand = INVALID_IP_ADDRESS
        elevation = INVALID_IP_ADDRESS
        usagetype = INVALID_IP_ADDRESS
    end
    results = {}
    results['country_short'] = country_short
    results['country_long'] = country_long
    results['region'] = region
    results['city'] = city
    results['latitude'] = latitude
    results['longitude'] = longitude
    results['isp'] = isp
    results['domain'] = domain
    results['netspeed'] = netspeed
    results['areacode'] = areacode
    results['iddcode'] = iddcode
    results['timezone'] = timezone
    results['zipcode'] = zipcode
    results['weatherstationname'] = weatherstationname
    results['weatherstationcode'] = weatherstationcode
    results['mcc'] = mcc
    results['mnc'] = mnc
    results['mobilebrand'] = mobilebrand
    results['elevation'] = elevation
    results['usagetype'] = usagetype
    return results
  end

  def get_country_short(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_short = (defined?(rec.country_short) && rec.country_short != '') ? rec.country_short : FIELD_NOT_SUPPORTED
        else
            country_short = INVALID_IP_ADDRESS
        end
    else
        country_short = INVALID_IP_ADDRESS
    end
    return country_short
  end

  def get_country_long(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_long = (defined?(rec.country_long) && rec.country_long != '') ? rec.country_long : FIELD_NOT_SUPPORTED
        else
            country_long = INVALID_IP_ADDRESS
        end
    else
        country_long = INVALID_IP_ADDRESS
    end
    return country_long
  end

  def get_region(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            region = (defined?(rec.region) && rec.region != '') ? rec.region : FIELD_NOT_SUPPORTED
        else
            region = INVALID_IP_ADDRESS
        end
    else
        region = INVALID_IP_ADDRESS
    end
    return region
  end

  def get_city(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            city = (defined?(rec.city) && rec.city != '') ? rec.city : FIELD_NOT_SUPPORTED
        else
            city = INVALID_IP_ADDRESS
        end
    else
        city = INVALID_IP_ADDRESS
    end
    return city
  end

  def get_latitude(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            latitude = (defined?(rec.latitude) && rec.latitude != '') ? rec.latitude : FIELD_NOT_SUPPORTED
        else
            latitude = INVALID_IP_ADDRESS
        end
    else
        latitude = INVALID_IP_ADDRESS
    end
    return latitude
  end

  def get_longitude(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            longitude = (defined?(rec.longitude) && rec.longitude != '') ? rec.longitude : FIELD_NOT_SUPPORTED
        else
            longitude = INVALID_IP_ADDRESS
        end
    else
        longitude = INVALID_IP_ADDRESS
    end
    return longitude
  end

  def get_isp(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            isp = (defined?(rec.isp) && rec.isp != '') ? rec.isp : FIELD_NOT_SUPPORTED
        else
            isp = INVALID_IP_ADDRESS
        end
    else
        isp = INVALID_IP_ADDRESS
    end
    return isp
  end

  def get_domain(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            domain = (defined?(rec.domain) && rec.domain != '') ? rec.domain : FIELD_NOT_SUPPORTED
        else
            domain = INVALID_IP_ADDRESS
        end
    else
        domain = INVALID_IP_ADDRESS
    end
    return domain
  end

  def get_zipcode(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            zipcode = (defined?(rec.zipcode) && rec.zipcode != '') ? rec.zipcode : FIELD_NOT_SUPPORTED
        else
            zipcode = INVALID_IP_ADDRESS
        end
    else
        zipcode = INVALID_IP_ADDRESS
    end
    return zipcode
  end

  def get_timezone(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            timezone = (defined?(rec.timezone) && rec.timezone != '') ? rec.timezone : FIELD_NOT_SUPPORTED
        else
            timezone = INVALID_IP_ADDRESS
        end
    else
        timezone = INVALID_IP_ADDRESS
    end
    return timezone
  end

  def get_netspeed(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            netspeed = (defined?(rec.netspeed) && rec.netspeed != '') ? rec.netspeed : FIELD_NOT_SUPPORTED
        else
            netspeed = INVALID_IP_ADDRESS
        end
    else
        netspeed = INVALID_IP_ADDRESS
    end
    return netspeed
  end

  def get_iddcode(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            iddcode = (defined?(rec.iddcode) && rec.iddcode != '') ? rec.iddcode : FIELD_NOT_SUPPORTED
        else
            iddcode = INVALID_IP_ADDRESS
        end
    else
        iddcode = INVALID_IP_ADDRESS
    end
    return iddcode
  end

  def get_areacode(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            areacode = (defined?(rec.areacode) && rec.areacode != '') ? rec.areacode : FIELD_NOT_SUPPORTED
        else
            areacode = INVALID_IP_ADDRESS
        end
    else
        areacode = INVALID_IP_ADDRESS
    end
    return areacode
  end

  def get_weatherstationcode(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            weatherstationcode = (defined?(rec.weatherstationcode) && rec.weatherstationcode != '') ? rec.weatherstationcode : FIELD_NOT_SUPPORTED
        else
            weatherstationcode = INVALID_IP_ADDRESS
        end
    else
        weatherstationcode = INVALID_IP_ADDRESS
    end
    return weatherstationcode
  end

  def get_weatherstationname(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            weatherstationname = (defined?(rec.weatherstationname) && rec.weatherstationname != '') ? rec.weatherstationname : FIELD_NOT_SUPPORTED
        else
            weatherstationname = INVALID_IP_ADDRESS
        end
    else
        weatherstationname = INVALID_IP_ADDRESS
    end
    return weatherstationname
  end

  def get_mcc(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            mcc = (defined?(rec.mcc) && rec.mcc != '') ? rec.mcc : FIELD_NOT_SUPPORTED
        else
            mcc = INVALID_IP_ADDRESS
        end
    else
        mcc = INVALID_IP_ADDRESS
    end
    return mcc
  end

  def get_mnc(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            mnc = (defined?(mnc) && rec.mnc != '') ? rec.mnc : FIELD_NOT_SUPPORTED
        else
            mnc = INVALID_IP_ADDRESS
        end
    else
        mnc = INVALID_IP_ADDRESS
    end
    return mnc
  end

  def get_mobilebrand(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            mobilebrand = (defined?(rec.mobilebrand) && rec.mobilebrand != '') ? rec.mobilebrand : FIELD_NOT_SUPPORTED
        else
            mobilebrand = INVALID_IP_ADDRESS
        end
    else
        mobilebrand = INVALID_IP_ADDRESS
    end
    return mobilebrand
  end

  def get_elevation(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            elevation = (defined?(rec.elevation) && rec.elevation != '') ? rec.elevation : FIELD_NOT_SUPPORTED
        else
            elevation = INVALID_IP_ADDRESS
        end
    else
        elevation = INVALID_IP_ADDRESS
    end
    return elevation
  end

  def get_usagetype(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            usagetype = (defined?(rec.usagetype) && rec.usagetype != '') ? rec.usagetype : FIELD_NOT_SUPPORTED
        else
            usagetype = INVALID_IP_ADDRESS
        end
    else
        usagetype = INVALID_IP_ADDRESS
    end
    return usagetype
  end

  def bsearch(low, high, ipnum, base_addr, col_length)
    while low <= high do
        mid = (low + high) >> 1
        ip_from, ip_to = get_from_to(mid, base_addr, col_length)
        if ipnum >= ip_from && ipnum < ip_to
            from_base = ( base_addr + mid * (col_length + (self.v4 ? 0 : 12)))
            file.seek(from_base)
            if v4
                return self.record_class4.read(file)
            else
                return self.record_class6.read(file)
            end
        else
            if ipnum < ip_from
                high = mid - 1
            else
                low = mid + 1
            end
        end
    end    
  end

  def get_from_to(mid, base_addr, col_length)
    from_base = ( base_addr + mid * (col_length + (v4 ? 0 : 12)))
    file.seek(from_base)
    ip_from = v4 ? file.read(4).unpack('V').first : readipv6(file)
    file.seek(from_base + col_length + (v4 ? 0 : 12))
    ip_to = v4 ? file.read(4).unpack('V').first : readipv6(file)
    [ip_from, ip_to]
  end

  def validateip(ip)
    if ip.ipv4?
        ipv = 4
        ipnum = ip.to_i + 0
    else
        ipv = 6
        ipnum = ip.to_i + 0
        #reformat ipv4 address in ipv6 
        if ipnum >= 281470681743360 && ipnum <= 281474976710655
            ipv = 4
            ipnum = ipnum - 281470681743360
        end
        #reformat 6to4 address to ipv4 address 2002:: to 2002:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF
        if ipnum >= 42545680458834377588178886921629466624 && ipnum <= 42550872755692912415807417417958686719
            ipv = 4
            #bitshift right 80 bits
            ipnum = ipnum >> 80
            #bitwise modulus to get the last 32 bit
            ipnum = ipnum % 4294967296
        end
        #reformat Teredo address to ipv4 address 2001:0000:: to 2001:0000:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:
        if ipnum >= 42540488161975842760550356425300246528 && ipnum <= 42540488241204005274814694018844196863
            ipv = 4
            #bitwise not to invert binary
            ipnum = ~ipnum
            #bitwise modulus to get the last 32 bit
            ipnum = ipnum % 4294967296
        end
    end
    [ipv, ipnum]
  end

  def read32(indexp)
    file.seek(indexp - 1)
    return file.read(4).unpack('V').first
  end

  def readipv6(filer)
    parts = filer.read(16).unpack('V*')
    return parts[0] + parts[1] * 4294967296 + parts[2] * 4294967296**2 + parts[3] * 4294967296**3
  end

  private :get_record, :bsearch, :get_from_to, :read32, :readipv6
end

class Ip2locationWebService
  attr_accessor :ws_api_key, :ws_package

  def initialize(api_key, package)
    if !api_key.match(/^[0-9A-Z]{10}$/) && api_key != 'demo'
      raise Exception.new "Please provide a valid IP2Location web service API key."
    end
    if !package.match(/^WS[0-9]+$/)
      package = 'WS1'
    end
    self.ws_api_key = api_key
    self.ws_package = package
  end

  def lookup(ip, add_ons, language)
    response =  Net::HTTP.get(URI("https://api.ip2location.com/v2/?key=" + self.ws_api_key + "&ip=" + ip + "&package=" + self.ws_package + "&format=json&addon=" + add_ons + "&lang=" + language))
    parsed_response = JSON.parse(response)
    if parsed_response.nil?
      return false
    end
    if !parsed_response["response"].nil?
      raise Exception.new "Error: " + parsed_response["response"]
    end
    return parsed_response
  end

  def get_credit()
    response =  Net::HTTP.get(URI("https://api.ip2location.com/v2/?key=" + self.ws_api_key + "&check=true"))
    parsed_response = JSON.parse(response)
    if parsed_response.nil?
      return 0
    end
    if parsed_response["response"].nil?
      return 0
    end
    return parsed_response["response"]
  end
end