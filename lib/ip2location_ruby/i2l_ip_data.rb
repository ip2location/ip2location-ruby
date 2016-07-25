class I2lIpData  < BinData::BasePrimitive
  def read_and_return_value(io)
    iv = eval_parameter(:ip_version)
    if iv == 4
      addr = BinData::Uint32le.read(io)
    elsif iv == 6
      addr = BinData::Uint128le.read(io)
    end
  end
end