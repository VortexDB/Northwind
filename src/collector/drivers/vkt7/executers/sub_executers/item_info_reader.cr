module Vkt7Driver
  # Read Vkt7 item info
  class ItemInfoReader < BaseExecuter(ParameterInfoWithData)
    # Size of digits element
    DIGITS_SIZE = 1_u16
    # Size of measure type element
    MEASURE_TYPE_SIZE = 7_u16

    # Parameters to get data
    @requests = Set(ParameterInfo).new

    # Add item to read info
    def addItemType(parameter : ParameterInfo) : Void
      @requests.add(parameter)
    end

    # Execute and iterate values in block
    def execute(&block : ParameterInfoWithData -> Void) : Void
      network = @deviceInfo.networkNumber.to_u8

      elementRequests = Array(ElementRequest).new

      @requests.each do |item|
        element = ElementRequest.new(item.digitsType, DIGITS_SIZE)
        elementRequests.push(element)
        element = ElementRequest.new(item.measureType, MEASURE_TYPE_SIZE)
        elementRequests.push(element)
      end

      # Select data type
      response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
        network, Vkt7StartAddress::WriteDataType, 0_u16, Bytes[0x02, Vkt7DataType::Property, 0x00]))

      # Select items
      itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol)
      elementRequests.each do |x|
        itemSelector.addItemType(x)
      end
      itemSelector.execute

      dataReader = ItemValueReader.new(@deviceInfo, @protocol)
      elementRequests.each do |item|
        dataReader.addItemType(item)
      end

      dataReader.execute do |value|

      end

      # # Read values
      # response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::ReadDataAddress, 0_u16))
      # binary = IO::Memory.new

    end
  end
end
