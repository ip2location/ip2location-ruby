class I2lStringData  < BinData::BasePrimitive
  
  def read_and_return_value(io)
    country_long = eval_parameter(:country_long)
    io.seekbytes(-4) if country_long
    file = io.instance_variable_get('@raw_io')
    addr = BinData::Uint32le.read(io)
    old_offset = file.tell
    country_long ? file.seek(addr + 3) : file.seek(addr)
    length = BinData::Uint8.read(file)
    res = BinData::String.new(:length => length).read(file)
    file.seek(old_offset)
    res
  end

end