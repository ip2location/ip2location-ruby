class I2lFloatData  < BinData::BasePrimitive
  
  def read_and_return_value(io)
    addr = BinData::FloatLe.read(io)
  end
  
end