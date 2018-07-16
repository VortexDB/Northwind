# lib LibC
#   VTIME = 16
#   O_NOCTTY = 0o0400

#   fun cfsetospeed(tty : LibC::Termios*, speed : UInt) : Void
#   fun cfsetispeed(tty : LibC::Termios*, speed : UInt) : Void
# end

# For working with serial port
class SerialPort < IO
    # Open port
    def open(port : String, speed : Int32, byte : String) : Void
    end

    def read(slice : Bytes)
        0
      end
    
      def write(slice : Bytes)
        nil
      end

    # To destroy port
    def finalize : Void
    end
end


# #fl = File.new("/dev/ttyUSB0", "w+")

# fd = LibC.open("/dev/ttyUSB0", LibC::O_RDWR | LibC::O_NOCTTY | LibC::O_NONBLOCK, 0o0600)

# LibC.fcntl(fd, LibC::F_SETFL, 0)

# LibC.tcgetattr(fd, out termiosOption)

#LibC.cfsetospeed(pointerof(termiosOption), 115200)
#LibC.cfsetispeed(pointerof(termiosOption), 115200)

# termiosOption.c_cflag |= LibC::CLOCAL
# termiosOption.c_cflag |= LibC::CREAD

# termiosOption.c_cc[LibC::VTIME] = 5
# termiosOption.c_cc[LibC::VMIN] = 1

# termiosOption.c_ispeed = 115200
# termiosOption.c_ospeed = 115200

# termiosOption.c_iflag &= ~(LibC::IXON | LibC::IXOFF | LibC::IXANY)

# termiosOption.c_cflag |= LibC::CS8
# termiosOption.c_cflag |= LibC::CSTOPB

# termiosOption.c_cflag |= LibC::PARENB
# termiosOption.c_cflag |= LibC::PARODD

# p termiosOption

#p LibC.tcsetattr(fd, Termios::LineControl::TCSANOW, pointerof(termiosOption))

# io = IO::FileDescriptor.new(fd.as(Int32))
# io.as(IO::FileDescriptor).sync = true

# spawn do
#     loop do
#         p io.gets 
#     end
# end

# loop do
#     s = gets
#     io.puts "#{s}\r"
# end

# LibC.close(fd.as(Int32))