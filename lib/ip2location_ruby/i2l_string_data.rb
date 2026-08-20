class I2lStringData < BinData::BasePrimitive
  def read_and_return_value(io)
    country_long = eval_parameter(:country_long)
    raw_io = io.instance_variable_get(:@io)
    initial_pos = raw_io.instance_variable_get(:@initial_pos)
    if country_long
      io.seek_to_abs_offset(raw_io.offset - 4)
    end
    addr = BinData::Uint32le.read(io)
    old_offset = raw_io.offset
    string_offset = country_long ? addr + 3 : addr
    relative_offset = string_offset - initial_pos
    io.seek_to_abs_offset(relative_offset)
    length = BinData::Uint8.read(io)
    result = BinData::String.new(:length => length).read(io)
    io.seek_to_abs_offset(old_offset)
    result
  end
end