# encoding: utf-8
require 'bindata'
require 'ipaddr'
require 'net/http'
require 'json'
require 'csv'
require 'ip2location_ruby/ip2location_config'
require 'ip2location_ruby/database_config'
require 'ip2location_ruby/i2l_float_data'
require 'ip2location_ruby/i2l_string_data'
require 'ip2location_ruby/i2l_ip_data'
require 'ip2location_ruby/ip2location_record'

class Ip2location
  attr_accessor :record_class4, :record_class6, :v4, :file, :db_index, :count, :base_addr, :ipno, :count, :record, :database, :columns, :ip_version, :ipv4databasecount, :ipv4databaseaddr, :ipv4indexbaseaddr, :ipv6databasecount, :ipv6databaseaddr, :ipv6indexbaseaddr, :databaseyear, :databasemonth, :databaseday, :last_err_msg

  VERSION = '8.7.0'
  FIELD_NOT_SUPPORTED = 'NOT SUPPORTED'
  INVALID_IP_ADDRESS = 'INVALID IP ADDRESS'
  INVALID_BIN_DATABASE = 'Incorrect IP2Location BIN file format. Please make sure that you are using the latest IP2Location BIN file.'
  IPV6_ADDRESS_IN_IPV4_BIN  = 'IPV6 ADDRESS MISSING IN IPV4 BIN'

  def open(url)
    if url == ''
        self.last_err_msg = 'Ip2location.new.open() requires a database path name.'
        abort('Ip2location.new.open() requires a database path name.')
    end

    begin
        self.file = File.open(File.expand_path(url), 'rb')
    rescue
        self.last_err_msg = 'Ip2location.new.open() error in opening ' + url +'.'
        abort('Ip2location.new.open() error in opening ' + url + '. No such file in the /your_ip2location_ruby_library_path/rb/ folder.')
    else
    end
    i2l = Ip2locationConfig.read(file)
    if i2l.productcode == 1
    else
        if i2l.databaseyear <= 20 && i2l.productcode == 0
        else
            self.file.close
            self.last_err_msg = INVALID_BIN_DATABASE
            abort(INVALID_BIN_DATABASE)
        end
    end
    self.db_index = i2l.databasetype
    self.columns = i2l.databasecolumn + 0
    self.databaseyear = 2000 + i2l.databaseyear
    self.databasemonth = i2l.databasemonth
    self.databaseday = i2l.databaseday
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

  def get_last_error_message()
    return self.last_err_msg
  end

  def get_module_version()
    return VERSION
  end

  def get_package_version()
    return (self.db_index).to_s
  end

  def get_database_version()
    return (self.databaseyear).to_s + "." + (self.databasemonth).to_s + "." + (self.databaseday).to_s
  end

  def get_record(ip)
    ipno = IPAddr.new(ip, Socket::AF_UNSPEC)
    self.ip_version, ipnum = validateip(ipno)
    self.v4 = ip_version == 4 ? true : false
    self.count = v4 ? self.ipv4databasecount + 0 : self.ipv6databasecount + 0
    self.base_addr = (v4 ? self.ipv4databaseaddr - 1 : self.ipv6databaseaddr - 1)
    if ip_version == 6 && self.ipv6databasecount == 0
        return IPV6_ADDRESS_IN_IPV4_BIN
    end
    col_length = self.columns * 4
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
        low, high = read32x2(indexpos)
        return self.record = bsearch(low, high, ipnum, self.base_addr, col_length)
    else
        return self.record = bsearch(0, self.count, ipnum, self.base_addr, col_length)
    end
  end

  def get_all(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            country_short = IPV6_ADDRESS_IN_IPV4_BIN
            country_long = IPV6_ADDRESS_IN_IPV4_BIN
            region = IPV6_ADDRESS_IN_IPV4_BIN
            city = IPV6_ADDRESS_IN_IPV4_BIN
            latitude = IPV6_ADDRESS_IN_IPV4_BIN
            longitude = IPV6_ADDRESS_IN_IPV4_BIN
            isp = IPV6_ADDRESS_IN_IPV4_BIN
            domain = IPV6_ADDRESS_IN_IPV4_BIN
            netspeed = IPV6_ADDRESS_IN_IPV4_BIN
            areacode = IPV6_ADDRESS_IN_IPV4_BIN
            iddcode = IPV6_ADDRESS_IN_IPV4_BIN
            timezone = IPV6_ADDRESS_IN_IPV4_BIN
            zipcode = IPV6_ADDRESS_IN_IPV4_BIN
            weatherstationname = IPV6_ADDRESS_IN_IPV4_BIN
            weatherstationcode = IPV6_ADDRESS_IN_IPV4_BIN
            mcc = IPV6_ADDRESS_IN_IPV4_BIN
            mnc = IPV6_ADDRESS_IN_IPV4_BIN
            mobilebrand = IPV6_ADDRESS_IN_IPV4_BIN
            elevation = IPV6_ADDRESS_IN_IPV4_BIN
            usagetype = IPV6_ADDRESS_IN_IPV4_BIN
            addresstype = IPV6_ADDRESS_IN_IPV4_BIN
            category = IPV6_ADDRESS_IN_IPV4_BIN
            district = IPV6_ADDRESS_IN_IPV4_BIN
            asn = IPV6_ADDRESS_IN_IPV4_BIN
            as = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
            addresstype = (defined?(rec.addresstype) && rec.addresstype != '') ? rec.addresstype : FIELD_NOT_SUPPORTED
            category = (defined?(rec.category) && rec.category != '') ? rec.category : FIELD_NOT_SUPPORTED
            district = (defined?(rec.district) && rec.district != '') ? rec.district : FIELD_NOT_SUPPORTED
            asn = (defined?(rec.asn) && rec.asn != '') ? rec.asn : FIELD_NOT_SUPPORTED
            as = (defined?(rec.as) && rec.as != '') ? rec.as : FIELD_NOT_SUPPORTED
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
            addresstype = INVALID_IP_ADDRESS
            category = INVALID_IP_ADDRESS
            district = INVALID_IP_ADDRESS
            asn = INVALID_IP_ADDRESS
            as = INVALID_IP_ADDRESS
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
        addresstype = INVALID_IP_ADDRESS
        category = INVALID_IP_ADDRESS
        district = INVALID_IP_ADDRESS
        asn = INVALID_IP_ADDRESS
        as = INVALID_IP_ADDRESS
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
    results['addresstype'] = addresstype
    results['category'] = category
    results['district'] = district
    results['asn'] = asn
    results['as'] = as
    return results
  end

  def get_country_short(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            country_short = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            country_long = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            region = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            city = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            latitude = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            longitude = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            isp = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            domain = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            zipcode = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            timezone = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            netspeed = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            iddcode = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            areacode = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            weatherstationcode = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            weatherstationname = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            mcc = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            mnc = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
            mnc = (defined?(rec.mnc) && rec.mnc != '') ? rec.mnc : FIELD_NOT_SUPPORTED
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            mobilebrand = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            elevation = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
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
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            usagetype = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
            usagetype = (defined?(rec.usagetype) && rec.usagetype != '') ? rec.usagetype : FIELD_NOT_SUPPORTED
        else
            usagetype = INVALID_IP_ADDRESS
        end
    else
        usagetype = INVALID_IP_ADDRESS
    end
    return usagetype
  end

  def get_addresstype(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            addresstype = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
            addresstype = (defined?(rec.addresstype) && rec.addresstype != '') ? rec.addresstype : FIELD_NOT_SUPPORTED
        else
            addresstype = INVALID_IP_ADDRESS
        end
    else
        addresstype = INVALID_IP_ADDRESS
    end
    return addresstype
  end

  def get_category(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
            category = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
            category = (defined?(rec.category) && rec.category != '') ? rec.category : FIELD_NOT_SUPPORTED
        else
            category = INVALID_IP_ADDRESS
        end
    else
        category = INVALID_IP_ADDRESS
    end
    return category
  end

  def get_district(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
          district = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
          district = (defined?(rec.district) && rec.district != '') ? rec.district : FIELD_NOT_SUPPORTED
        else
          district = INVALID_IP_ADDRESS
        end
    else
      district = INVALID_IP_ADDRESS
    end
    return district
  end

  def get_asn(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
          asn = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
          asn = (defined?(rec.asn) && rec.asn != '') ? rec.asn : FIELD_NOT_SUPPORTED
        else
          asn = INVALID_IP_ADDRESS
        end
    else
      asn = INVALID_IP_ADDRESS
    end
    return asn
  end

  def get_as(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if rec == IPV6_ADDRESS_IN_IPV4_BIN
          as = IPV6_ADDRESS_IN_IPV4_BIN
        elsif !(rec.nil?)
          as = (defined?(rec.as) && rec.as != '') ? rec.as : FIELD_NOT_SUPPORTED
        else
          as = INVALID_IP_ADDRESS
        end
    else
      as = INVALID_IP_ADDRESS
    end
    return as
  end

  def bsearch(low, high, ipnum, base_addr, col_length)
    while low <= high do
        mid = (low + high) >> 1
        ip_from, ip_to = get_from_to(mid, base_addr, col_length)
        if ipnum >= ip_from && ipnum < ip_to
            from_base = (base_addr + mid * (col_length + (self.v4 ? 0 : 12)))
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
    from_base = (base_addr + mid * (col_length + (v4 ? 0 : 12)))
    data_length = col_length + (v4 ? 4 : (12 + 16))
    file.seek(from_base)
    data_read = file.read(data_length)
    ip_from = v4 ? data_read[0..3].unpack('V').first : readipv6(data_read[0..15].unpack('V*'))
    ip_to = v4 ? data_read[(data_length - 4)..(data_length - 1)].unpack('V').first : readipv6(data_read[(data_length - 16)..(data_length - 1)].unpack('V*'))
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

  def read32x2(indexp)
    file.seek(indexp - 1)
    data_read = file.read(8)
    data1 = data_read[0..3].unpack('V').first
    data2 = data_read[4..7].unpack('V').first
    return [data1, data2]
  end

  def readipv6(parts)
    return parts[0] + parts[1] * 4294967296 + parts[2] * 4294967296**2 + parts[3] * 4294967296**3
  end

  private :get_record, :bsearch, :get_from_to, :read32x2, :readipv6
end

class Ip2locationWebService
  attr_accessor :ws_api_key, :ws_package, :ws_use_ssl

  def initialize(api_key, package, use_ssl)
    if !api_key.match(/^[0-9A-Z]{10}$/) && api_key != 'demo'
      raise Exception.new "Please provide a valid IP2Location web service API key."
    end
    if !package.match(/^WS[0-9]+$/)
      package = 'WS1'
    end
    if use_ssl == ''
      use_ssl = true
    end
    self.ws_api_key = api_key
    self.ws_package = package
    self.ws_use_ssl = use_ssl
  end

  def lookup(ip, add_ons, language)
    if self.ws_use_ssl
      response =  Net::HTTP.get(URI("https://api.ip2location.com/v2/?key=" + self.ws_api_key + "&ip=" + ip + "&package=" + self.ws_package + "&format=json&addon=" + add_ons + "&lang=" + language))
    else
      response =  Net::HTTP.get(URI("http://api.ip2location.com/v2/?key=" + self.ws_api_key + "&ip=" + ip + "&package=" + self.ws_package + "&format=json&addon=" + add_ons + "&lang=" + language))
    end
    parsed_response = JSON.parse(response)
    if parsed_response.nil?
      return false
    end
    if parsed_response["country_code"].nil?
      raise Exception.new "Error: " + parsed_response["response"]
    end
    return parsed_response
  end

  def get_credit()
    if self.ws_use_ssl
      response =  Net::HTTP.get(URI("https://api.ip2location.com/v2/?key=" + self.ws_api_key + "&check=true"))
    else
      response =  Net::HTTP.get(URI("http://api.ip2location.com/v2/?key=" + self.ws_api_key + "&check=true"))
    end
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

class Ip2locationIpTools
  def is_ipv4(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      if IPAddr.new(ip).ipv4?
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def is_ipv6(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      if IPAddr.new(ip).ipv6?
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def ipv4_to_decimal(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      ip = IPAddr.new(ip)
      if ip.ipv4?
        return ip.to_i
      else
        return
      end
    else
      return
    end
  end

  def decimal_to_ipv4(number)
    if number.is_a? Numeric
      return IPAddr.new(number, Socket::AF_INET).to_s
    else
      return
    end
  end

  def ipv6_to_decimal(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      ip = IPAddr.new(ip)
      if ip.ipv6?
        return ip.to_i
      else
        return
      end
    else
      return
    end
  end

  def decimal_to_ipv6(number)
    if number.is_a? Numeric
      return IPAddr.new(number, Socket::AF_INET6).to_s
    else
      return
    end
  end

  def ipv4_to_cidr(ipfrom, ipto)
    if (!(IPAddr.new(ipfrom) rescue nil).nil?) and (!(IPAddr.new(ipto) rescue nil).nil?)
      ipfrom = IPAddr.new(ipfrom)
      ipto = IPAddr.new(ipto)
      if ipfrom.ipv4? and ipto.ipv4?
        ipfrom = ipfrom.to_i
        ipto = ipto.to_i
        result = []
        while ipto >= ipfrom do
          maxSize = 32
          while maxSize > 0 do
            mask = (2**32 - 2**(32-(maxSize - 1)))
            maskBase = ipfrom & mask
            if maskBase != ipfrom
              break
            end
              maxSize-=1
          end
          x = Math.log(ipto - ipfrom + 1)/Math.log(2)
          maxDiff = (32 - x.floor).floor

          if maxSize < maxDiff
            maxSize = maxDiff
          end

          ip = IPAddr.new(ipfrom, Socket::AF_INET).to_s
          cidr = [ip, maxSize].join('/')
          result.push cidr
          ipfrom += 2**(32-maxSize)
        end
        return result
      else
        return
      end
    else
      return
    end
  end

  def cidr_to_ipv4(cidr)
    if cidr.include? "/"
      cidr = IPAddr.new(cidr)
      arr_tmp = cidr.to_range.to_s.split('..')
      ip_arr = {}
      ip_arr['ip_start'] = arr_tmp[0]
      ip_arr['ip_end'] = arr_tmp[1]
      return ip_arr
    else
      return
    end
  end

  def ipv6_to_cidr(ipfrom_ori, ipto)
    if (!(IPAddr.new(ipfrom_ori) rescue nil).nil?) and (!(IPAddr.new(ipto) rescue nil).nil?)
      ipfrom = IPAddr.new(ipfrom_ori)
      ipto = IPAddr.new(ipto)
      if ipfrom.ipv6? and ipto.ipv6?
        ipfrom = '00' + ipfrom.to_i.to_s(2)
        ipto = '00' + ipto.to_i.to_s(2)
        result = []
        if ipfrom == ipto
          cidr = ipfrom_ori + '/128'
          result.push cidr
          return result
        end
        if ipfrom > ipto
          ipfrom, ipto = ipto, ipfrom
        end
        networks = {}
        network_size = 0
        while ipto > ipfrom do
          if ipfrom[-1, 1] == '1'
            networks[ipfrom[network_size, (128 - network_size)] + ('0' * network_size)] = 128 - network_size
            n = ipfrom.rindex('0')
            ipfrom = ((n == 0) ? '' : ipfrom[0, n]) + '1' + ('0' * (128 - n - 1))
          end

          if ipto[-1, 1] == '0'
            networks[ipto[network_size, (128 - network_size)] + ('0' * network_size)] = 128 - network_size
            n = ipto.rindex('1')
            ipto = ((n == 0) ? '' : ipto[0, n]) + '0' + ('1' * (128 - n - 1))
          end

          if ipfrom > ipto
            next
          end

          shift = 128 - [ipfrom.rindex('0'), ipto.rindex('1')].max
          ipfrom = ('0' * shift) + ipfrom[0, (128 - shift)]
          ipto = ('0' * shift) + ipto[0, (128 - shift)]
          network_size = network_size + shift

          if ipfrom == ipto
            networks[ipfrom[network_size, (128 - network_size)] + ('0' * network_size)] = 128 - network_size
            next
          end
        end

        networks.each do |ip, netmask|
          result.push IPAddr.new(ip.to_i(2), Socket::AF_INET6).to_s + '/' + netmask.to_s
        end
        return result
      else
        return
      end
    else
      return
    end
  end

  def cidr_to_ipv6(cidr)
    if cidr.include? "/"
      ip_start = IPAddr.new(cidr.to_s.split('/').first).to_i.to_s(16).scan(/.{4}/)
      ip_start = ip_start[0] + ':' + ip_start[1] + ':' + ip_start[2] + ':' + ip_start[3] + ':' + ip_start[4] + ':' + ip_start[5] + ':' + ip_start[6] + ':' + ip_start[7]

      cidr_new = IPAddr.new(cidr)
      arr_tmp = cidr_new.to_range.to_s.split('..')
      ip_end = IPAddr.new(arr_tmp[1]).to_i.to_s(16).scan(/.{4}/)
      ip_end = ip_end[0] + ':' + ip_end[1] + ':' + ip_end[2] + ':' + ip_end[3] + ':' + ip_end[4] + ':' + ip_end[5] + ':' + ip_end[6] + ':' + ip_end[7]

      ip_arr = {}
      ip_arr['ip_start'] = ip_start
      ip_arr['ip_end'] = ip_end
      return ip_arr
    else
      return
    end
  end

  def compress_ipv6(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      ip = IPAddr.new(ip)
      if ip.ipv6?
        return ip
      else
        return
      end
    else
      return
    end
  end

  def expand_ipv6(ip)
    if !(IPAddr.new(ip) rescue nil).nil?
      ip = IPAddr.new(ip)
      if ip.ipv6?
        res = ip.to_i.to_s(16).scan(/.{4}/)
        return res[0] + ':' + res[1] + ':' + res[2] + ':' + res[3] + ':' + res[4] + ':' + res[5] + ':' + res[6] + ':' + res[7]
      else
        return
      end
    else
      return
    end
  end
end

class Ip2locationCountry
  attr_accessor :fields, :records

  def initialize(csv)
    if csv == ''
      abort('The CSV file "' + csv + '" is not found.')
    end

    begin
      csvfile = File.open(File.expand_path csv, 'rb')
    rescue
      abort('Error in opening ' + csv + '. No such CSV file in the /your_ip2location_ruby_library_path/rb/ folder.')
    else
    end

    begin
      CSV.parse(csvfile)
    rescue
      abort('Unable to read "' + csv + '".')
    else
      line = 1
      self.records = Hash.new
      CSV.foreach((csvfile)) do |data|
        if line == 1
          if data[0] != 'country_code'
            abort('Invalid country information CSV file.')
          end
          self.fields = data
        else
          self.records[data[0]] = data
        end
        line = line + 1
      end
    end
  end

  def get_country_info(country_code = nil)
    if self.records.empty?
      abort('No record available.')
    end

    if country_code
      if (self.records[country_code]).nil?
        return []
      end
      results = Hash.new
      for i in 0..(self.fields.length()-1)
        results[self.fields[i]] = self.records[country_code][i]
      end
      return results
    end

    results = []
    self.records.each do |key, value|
      data = Hash.new
      for i in 0..(self.fields.length()-1)
        data[self.fields[i]] = self.records[key][i]
      end
      results = results.append(data)
    end
    return results
  end
end

class Ip2locationRegion
  attr_accessor :records

  def initialize(csv)
    if csv == ''
      abort('The CSV file "' + csv + '" is not found.')
    end

    begin
      csvfile = File.open(File.expand_path csv, 'rb')
    rescue
      abort('Error in opening ' + csv + '. No such CSV file in the /your_ip2location_ruby_library_path/rb/ folder.')
    else
    end

    begin
      CSV.parse(csvfile)
    rescue
      abort('Unable to read "' + csv + '".')
    else
      line = 1
      self.records = Hash.new
      CSV.foreach((csvfile)) do |data|
        if line == 1
          if data[1] != 'subdivision_name'
            abort('Invalid region information CSV file.')
          end
        else
          temp_data = Hash.new
          temp_data['code'] = data[2]
          temp_data['name'] = data[1]
          if self.records[data[0]]
            self.records[data[0]].push temp_data
          else
            self.records[data[0]] = [temp_data]
          end
        end
        line = line + 1
      end
    end
  end

  def get_region_code(country_code, region_name)
    if self.records.empty?
      abort('No record available.')
    end

    if (self.records[country_code]).nil?
      return
    end

    for i in 0..(self.records[country_code].length()-1)
      if region_name.upcase == self.records[country_code][i]["name"].upcase
        return self.records[country_code][i]["code"]
      end
    end
  end
end
