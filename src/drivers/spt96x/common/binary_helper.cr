module Spt96xDriver
  # For working with protocol data
  module BinaryHelper
    # Add RequestParameter
    def self.addRequestParameter(io : IO, param : RequestParameter) : Void
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io << param.channel # Channel
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io << param.parameter # Parameter
      io.write_bytes(SpbusSpecialBytes::FF_BYTE)
    end
  end
end
