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

    # Add date to request
    def addDateRequest(io : IO, date : Time) : Void
      year = date.year - 2000

      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(date.day)
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(date.month)
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(year)
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(date.hour)
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(date.minute)
      io.write_bytes(SpbusSpecialBytes::HT_BYTE)
      io.write_bytes(date.second)
    end
  end
end
