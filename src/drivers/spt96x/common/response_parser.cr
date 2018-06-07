module Spt96xDriver
    # Parse response
    class ResponseParser
        # Encoding of response
        ENCODING = "cp866"

        # Decode bytes
        private def decodeBytes(data : Bytes) : String
            String.new(data, ENCODING)             
        end

        # Parse params from response of function read parameters
        def parseReadParameters(data : Bytes)
            str = decodeBytes(data)
        end
    end
end