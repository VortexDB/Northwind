module SpbusProtocol
  # Unpacker state
  enum SpbusUnpackerState
    Start,
    FunctionRead,
    HeadRead,
    DataRead,
    ReadCrc
  end

  # Frame unpacker
  class SpbusFrameUnpacker
    # Is DLE byte
    @isDle : Bool = false

    # Was DLE byte
    @wasDle : Bool = false

    # Unpacker state
    @state : SpbusUnpackerState = SpbusUnpackerState::Start

    # Function number
    @fnc : UInt8 = 0_u8

    # Buffer for full data to calc crc
    @buffer = IO::Memory.new

    # Buffer for data only
    @dataBuffer = IO::Memory.new

    # Crc
    @crc : UInt16?

    # Add bytes
    def addBytes(data : Bytes, count : Int32) : SpbusResponse?
      count.times do |i|
        b = data[i]
        if (!@isDle) && (b == SpbusSpecialBytes::DLE_BYTE)
          @wasDle = false
          @isDle = true
        elsif (@isDle)
          @isDle = false
          @wasDle = true
        else
          @wasDle = false
          @isDle = false
        end

        case @state
        when SpbusUnpackerState::Start
          if b == SpbusSpecialBytes::SOH_BYTE
            @state = SpbusUnpackerState::FunctionRead
          end
        when SpbusUnpackerState::FunctionRead
          @buffer.write_byte(b)
          if b == SpbusSpecialBytes::ISI_BYTE
            @fnc = b
          elsif @fnc == SpbusSpecialBytes::ISI_BYTE
            @fnc = b
            @state = SpbusUnpackerState::HeadRead
          end
        when SpbusUnpackerState::HeadRead
          @buffer.write_byte(b)
          if b == SpbusSpecialBytes::STX_BYTE && @wasDle
            @state = SpbusUnpackerState::DataRead
          end
        when SpbusUnpackerState::DataRead
          @buffer.write_byte(b)
          if b == SpbusSpecialBytes::ETX_BYTE && @wasDle
            @state = SpbusUnpackerState::ReadCrc
          elsif !@isDle
            @dataBuffer.write_byte(b)
          end
        when SpbusUnpackerState::ReadCrc
          if @crc.nil?
            @crc = b.to_u16
          else
            crc = @crc.not_nil!
            crc = (crc << 8) + b
            calcCrc = SpbusCrcHelper.calcCrc(@buffer.to_slice)
            if crc != calcCrc
              raise NorthwindException.new("Crc not equal")
            end

            return SpbusResponse.new(@fnc, @dataBuffer.to_slice)
          end
        else
          raise NorthwindException.new("Unknown unpacker state")
        end
      end
    end
  end
end
