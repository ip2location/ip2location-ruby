# encoding: utf-8
require 'bindata'
require 'ipaddr'
require 'ip2location_ruby/ip2location_config'
require 'ip2location_ruby/database_config'
require 'ip2location_ruby/i2l_float_data'
require 'ip2location_ruby/i2l_string_data'
require 'ip2location_ruby/i2l_ip_data'
require 'ip2location_ruby/ip2location_record'

class Ip2location
  attr_accessor :record_class4, :record_class6, :v4, :file, :db_index, :count, :base_addr, :ipno, :count, :record, :database, :columns, :ip_version, :ipv4databasecount, :ipv4databaseaddr, :ipv4indexbaseaddr, :ipv6databasecount, :ipv6databaseaddr, :ipv6indexbaseaddr
  
  def open(url)
    self.file = File.open(File.expand_path(url), 'rb')
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
  
  def get_all(ip)
    ipno = IPAddr.new(ip, Socket::AF_UNSPEC)
    self.ip_version = ipno.ipv4? ? 4 : 6
    self.v4 = ipno.ipv4?
    self.count = ipno.ipv4? ? self.ipv4databasecount + 0 : self.ipv6databasecount + 0
    self.base_addr = (ipno.ipv4? ? self.ipv4databaseaddr - 1 : self.ipv6databaseaddr - 1)
	
    ipnum = ipno.to_i + 0
    col_length = columns * 4
	
	if ipv4indexbaseaddr > 0 || ipv6indexbaseaddr > 0
		indexpos = 0
		case ip_version
		when 4
			ipnum1_2 = (ipnum >> 16)
			indexpos = ipv4indexbaseaddr + (ipnum1_2 << 3)
		when 6
			ipnum1 = (ipnum / (2**112))
			indexpos = ipv6indexbaseaddr + (ipnum1 << 3)
		end
		low = read32(indexpos)
		high = read32(indexpos + 4)
		return self.record = bsearch(low, high, ipnum, self.base_addr, col_length)
	else
		return self.record = bsearch(0, self.count, ipnum, self.base_addr, col_length)
	end
  end
  
  def get_country_short(ip)
	rec = get_all(ip)
	return rec.country_short
  end
  
  def get_country_long(ip)
	rec = get_all(ip)
	return rec.country_long
  end
  
  def get_region(ip)
	rec = get_all(ip)
	return rec.region
  end
  
  def get_city(ip)
	rec = get_all(ip)
	return rec.city
  end
  
  def get_latitude(ip)
	rec = get_all(ip)
	return rec.latitude
  end
  
  def get_longitude(ip)
	rec = get_all(ip)
	return rec.longitude
  end
  
  def get_isp(ip)
	rec = get_all(ip)
	return rec.isp
  end
  
  def get_domain(ip)
	rec = get_all(ip)
	return rec.domain
  end
  
  def get_zipcode(ip)
	rec = get_all(ip)
	return rec.zipcode
  end
  
  def get_timezone(ip)
	rec = get_all(ip)
	return rec.timezone
  end
  
  def get_netspeed(ip)
	rec = get_all(ip)
	return rec.netspeed
  end
  
  def get_iddcode(ip)
	rec = get_all(ip)
	return rec.iddcode
  end
  
  def get_areacode(ip)
	rec = get_all(ip)
	return rec.areacode
  end
  
  def get_weatherstationcode(ip)
	rec = get_all(ip)
	return rec.weatherstationcode
  end
  
  def get_weatherstationname(ip)
	rec = get_all(ip)
	return rec.weatherstationname
  end
  
  def get_mcc(ip)
	rec = get_all(ip)
	return rec.mcc
  end
  
  def get_mnc(ip)
	rec = get_all(ip)
	return rec.mnc
  end
  
  def get_mobilebrand(ip)
	rec = get_all(ip)
	return rec.mobilebrand
  end
  
  def get_elevation(ip)
	rec = get_all(ip)
	return rec.elevation
  end
  
  def get_usagetype(ip)
	rec = get_all(ip)
	return rec.usagetype
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
  
  def read32(indexp)
	file.seek(indexp - 1)
	return file.read(4).unpack('V').first
  end
  
  def readipv6(filer)
	parts = filer.read(16).unpack('V*')
	return parts[0] + parts[1] * 4294967296 + parts[2] * 4294967296**2 + parts[3] * 4294967296**3
  end
    
end