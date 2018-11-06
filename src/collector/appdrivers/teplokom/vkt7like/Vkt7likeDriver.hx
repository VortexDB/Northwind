package collector.appdrivers.teplokom.vkt7like;

import collector.common.task.CollectorDataTask;
import collector.common.task.CollectorActionTask;
import collector.common.protocol.TransportProtocol;
import collector.common.parameters.DeviceAction;
import collector.common.appdriver.CollectorMeterDriver;
import collector.common.appdriver.IDriverWithExecutionContext;
import collector.common.appdriver.event.ReadTimeResponseEvent;
import collector.common.appdriver.deviceinfo.DeviceInfo;
import collector.protocols.modbus.rtu.ModbusRtuProtocol;
import collector.appdrivers.teplokom.vkt7like.common.VktExecuterContext;
import collector.appdrivers.teplokom.vkt7like.executers.TimeReader;
import collector.appdrivers.teplokom.vkt7like.executers.ValueReader;

/**
 * Driver for Vkt7 like driver
 */
@:keep
class Vkt7likeDriver extends CollectorMeterDriver implements IDriverWithExecutionContext<VktExecuterContext> {
	/**
	 * Execution context
	 */
	public var executionContext:VktExecuterContext;

	/**
	 * Constructor
	 */
	public function new() {
		super(["Vkt7", "Vkg3"], new ModbusRtuProtocol());
	}

	/**
	 * Create new execution context
	 * @return T
	 */
	public function createExecutionContext(deviceInfo:DeviceInfo, protocol:TransportProtocol):VktExecuterContext {
		return new VktExecuterContext(deviceInfo, protocol);
	}

	/**
	 * Process execute actions. Virtual
	 * @param action
	 */
	public override function executeActions(actions:Array<CollectorActionTask>):Void {
		for (taskAction in actions) {
			switch (taskAction.action.actionType) {
				case ActionType.ReadDateTime:					
					var reader = new TimeReader(executionContext);
					reader.executeOne().onSuccess((dateTime) -> {
						notifyTaskEventAndComplete(new ReadTimeResponseEvent(taskAction.taskId, dateTime));
					});
				default:
					notifyTaskComplete(taskAction.taskId);
			}
		}
	}

	/**
	 * Process read current values
	 * @param tasks
	 * @return ) : Void
	 */
	public override function executeCurrentValues(tasks:Array<CollectorDataTask>):Void {
		var valueReader = new ValueReader(executionContext);
		for (taskData in tasks) {						
			valueReader.addParameter(taskData.parameter);
		}

		valueReader.execute().listen((value) -> {

		});
	}
}
