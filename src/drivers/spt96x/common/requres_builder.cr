module Spt96xDriver
  # Request parameter builder
  class RequestBuilder
    # Date parameter
    def self.date() : RequestParameter
      RequestParameter.new("0", "60")
    end

    # Date parameter
    def self.time() : RequestParameter
      RequestParameter.new("0", "61")
    end
  end
end