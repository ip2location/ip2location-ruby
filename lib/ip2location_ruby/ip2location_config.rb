class Ip2locationConfig < BinData::Record
  endian :little
  uint8 :databasetype
  uint8 :databasecolumn
  uint8 :databaseyear
  uint8 :databasemonth
  uint8 :databaseday
  # uint32 :databasecount
  # uint32 :databaseaddr
  # uint32 :ipversion
  uint32 :ipv4databasecount
  uint32 :ipv4databaseaddr
  uint32 :ipv6databasecount
  uint32 :ipv6databaseaddr
  uint32 :ipv4indexbaseaddr
  uint32 :ipv6indexbaseaddr
  uint8 :productcode
  uint8 :licensecode
  uint32 :databasesize
end