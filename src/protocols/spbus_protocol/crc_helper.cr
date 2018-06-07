# Helper for calculating crc
class SpbusCrcHelper
  # Calc crc for spbus protocol
  def self.calcCrc(bytes : Bytes)
    i = 0
    crc : Int32 = 0
    len = bytes.size
    while len > 0
      len -= 1
      crc = crc ^ (bytes[i].to_i32 << 8)
      i += 1
      (0..7).each do |i|
        if crc & 0x8000 > 0
          crc = (crc << 1) ^ 0x1021
        else
          crc <<= 1
        end
      end
    end
    return crc.to_u16
  end
end
