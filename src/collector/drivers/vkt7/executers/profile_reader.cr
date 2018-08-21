require "./common/base_executer"

module Vkt7Driver
  # Read profile from device
  class ProfileReader < CommonValueExecuter(Float64)
    # Execute and iterate values in block
    def postExecute(&block : Float64 -> Void) : Void
    end
  end
end
