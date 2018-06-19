module Spt96xDriver
  # Parse response
  class ResponseParser
    # Encoding of response
    ENCODING = "cp866"

    # Parse date HT Day HT Month HT Year HT Hour HT Minute HT Seconds
    def self.parseDateTime(str : String) : Time
      _,ds,mos,ys,hs,ms,ss = str.split(SpbusSpecialBytes::HT_BYTE.chr)

      year = ys.to_i32
      year = (year + 2000) if year <= 2000

      return Time.new(
        year,
        mos.to_i32,
        ds.to_i32,
        hs.to_i32,
        ms.to_i32,
        ss.to_i32
      )
    end

    # Parse date of format дд-мм-гг
    def self.parseDateValue(str : String, format : String) : Time
      if format == "дд-мм-гг"
        dd, mm, yy = str.split("-")
        year = yy.to_i32
        year = (year + 2000) if year <= 2000
        return Time.new(year, mm.to_i32, dd.to_i32)
      end

      raise NorthwindException.new("Unknown date format")
    end

    # Parse time of format чч:мм:сс
    def self.parseTimeValue(str : String, format : String) : Time::Span
      if format == "чч:мм:сс"
        hh, mm, ss = str.split(":")
        return Time::Span.new(hh.to_i32, mm.to_i32, ss.to_i32)
      end

      raise NorthwindException.new("Unknown time format")
    end

    # Parse parameter datetime
    def self.parseParameterDate(str : String) : Time
      dateItems, timeItems = str.split("/")
      year = dateItems[2].to_i32
      year = (year + 2000) if year <= 2000
      month = dateItems[1].to_i32
      day = dateItems[0].to_i32

      hour = timeItems[0].to_i32
      minute = timeItems[1].to_i32
      second = timeItems[2].to_i32

      return Time.new(year, month, day, hour, minute, second)
    end

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
      _, channel, param = str.split(SpbusSpecialBytes::HT_BYTE.chr)
      return RequestParameter.new(channel, param)
    end

    # Parse parameter data
    def parseParameterData(str : String) : ParameterData
      items = str.split(SpbusSpecialBytes::HT_BYTE.chr)
      items.shift

      value = items[0]
      measure = items[1] if items.size > 1
      date = ResponseParser.parseParameterDate(items[2]) if items.size > 2

      return ParameterData.new(value, measure, date)
    end

    # Parse params from response of function read parameters
    def parseReadParameters(data : Bytes, &block : ReadParameterResponse -> _) : Void
      items = parseItems(data)
      (0..items.size / 2).step(2) do |i|
        infoStr = items[i]
        dataStr = items[i + 1]
        par = parseRequestParameter(infoStr)
        date = parseParameterData(dataStr)
        yield ReadParameterResponse.new(par, date)
      end
    end

    # Parse params with array result
    def parseReadParametersToArray(data : Bytes) : Array(ReadParameterResponse)
      arr = Array(ReadParameterResponse).new
      parseReadParameters(data) do |x|
        arr << x
      end
      return arr
    end

    # Parse response for date archive reading
    def parseReadDateArchiveResponse(data : Bytes) : ReadDateArchiveResponse
      items = parseItems(data)
      parameter = parseRequestParameter(items[0])
      startDate = parseDateTime(item[1])
      endDate = parseDateTime(item[2])

      values = Array(ParameterData).new
      (3...item.size).each do |x|
        values << parseParameterData(items[x])
      end

      return ReadDateArchiveResponse.new(
        parameter: parameter,
        startDate: startDate,
        endDate: endDate,
        values: values
      )
    end
  end
end
