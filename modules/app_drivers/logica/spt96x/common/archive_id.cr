module Spt96xDriver
  # Id's of meter archive
  enum ArchiveId
    Hour   = 65530,
    Day    = 65532,
    Decade = 65528,
    Month  = 65534
  end
end

# Helper to get achive id by measure parameter
module Device
  class MeasureParameter
    # Get archive id by parameter
    def getArchiveId : Spt96xDriver::ArchiveId
      case discret.discretType
      when DiscretType::Month
        return Spt96xDriver::ArchiveId::Month
      when DiscretType::Day
        return Spt96xDriver::ArchiveId::Day
      when DiscretType::Hour
        return Spt96xDriver::ArchiveId::Hour
      end

      raise NorthwindException.new("Unknown discret type")
    end
  end
end
