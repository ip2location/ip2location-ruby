class Ip2locationConfig < BinData::Record
  endian :little
	uint8 :databasetype
	uint8 :databasecolumn
	uint8 :databaseday
	uint8 :databasemonth
	uint8 :databaseyear
	# uint32 :databasecount
	# uint32 :databaseaddr
	# uint32 :ipversion
  uint32 :ipv4databasecount
  uint32 :ipv4databaseaddr
  uint32 :ipv6databasecount
  uint32 :ipv6databaseaddr
  uint32 :ipv4indexbaseaddr
  uint32 :ipv6indexbaseaddr
end