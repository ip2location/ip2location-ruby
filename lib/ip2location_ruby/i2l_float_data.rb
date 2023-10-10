class I2lFloatData  < BinData::BasePrimitive
  
  def read_and_return_value(io)
    BinData::FloatLe.read(io)
  end
  
end
