module Spt96xDriver
  # Parse response
  class ResponseParser
    # Encoding of response
    ENCODING = "cp866"

    # Decode bytes
    private def decodeBytes(data : Bytes) : String
      String.new(data, ENCODING)
    end

    # Parse items
    def parseItems(data : Bytes) : Array(String)
      str = decodeBytes(data)
      items = str.split(SpbusSpecialBytes::FF_BYTE.chr)
      items.pop
      return items
    end

    # Parse request parameter
    def parseRequestParameter(str : String) : RequestParameter
        channel, param = str.split(SpbusSpecialBytes::HT_BYTE.chr)        
        return RequestParameter.new(channel, param)
    end

    # Parse parameter date
    def parseParameterDate(str : String) : Time
        
    end

    # Parse parameter data
    def parseParameterData(str : String) : ParameterData
        items = str.split(SpbusSpecialBytes::HT_BYTE.chr)

        value = items[0]
        measure = items[1] if items.size > 1
        date = parseParameterDate(parseitems[2]) if items.size > 2

        return ParameterData.new(value, measure, date)
    end

    # Parse params from response of function read parameters
    def parseReadParameters(data : Bytes, &block : ReadParameterResponse -> _) : Void
      items = parseItems(data)
      (0..items.size / 2).step(2) do |i|
        infoStr = items[i]
        dataStr = items[i + 1]
        par = parseRequestParameter(infoStr)
        date = 
        yield ReadParameterResponse.new(par, data)
      end
    end
  end
end
