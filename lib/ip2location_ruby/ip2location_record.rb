class Ip2LocationRecord 
  def self.init(database, ip_version)
    cls = Class.new(BinData::Record)
    cls.class_eval {
      endian :little
      i2l_ip_data :ip_from, :ip_version => ip_version
      database.each do |col|
        if [:latitude, :longitude].include? col.first
          i2l_float_data col.first
        elsif col.first == :country
          i2l_string_data :country_short
          i2l_string_data :country_long, :country_long => true
        else
          i2l_string_data col.first
        end
      end
      
      i2l_ip_data :ip_to, :ip_version => ip_version
    }
    cls 
  end
end