class I2lIpData  < BinData::BasePrimitive
  def read_and_return_value(io)
    iv = eval_parameter(:ip_version)
    if iv == 4
      BinData::Uint32le.read(io)
    elsif iv == 6
      BinData::Uint128le.read(io)
    end
  end
end
