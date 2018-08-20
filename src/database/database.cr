module Database
  # Client for database
  class DatabaseClient
    # TODO: remove
    @database : File

    def initialize
      @database = File.new("database.txt", "a")
      @database.flush_on_newline = true
    end

    # Write data values to database
    def writeValue(entity : EntityDataSource, parameter : EntityParameter, date : Time?, value : Float64) : Void
      strData = "Entity: #{entity.id} Parameter: #{parameter.id} Date: #{date} Value: #{value}\n"
      @database << strData
    end

    # Write data values to database
    def writeTime(entity : EntityDataSource, parameter : EntityParameter, date : Time?, value : Time) : Void
      strData = "Entity: #{entity.id} Parameter: #{parameter.id} Date: #{date} Value: #{value}\n"
      @database << strData
    end    
  end
end
