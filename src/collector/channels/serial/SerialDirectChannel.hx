package collector.channels.serial;

import haxe.io.Bytes;
import collector.common.channel.ClientTransportChannel;
import collector.common.channel.IBinaryChannel;

/**
 * Channel for communicating direct with serial port
 */
class SerialDirectChannel extends ClientTransportChannel implements IBinaryChannel {
    /**
     * Write bytes
     * @param data 
     */
    public function write(data:Bytes):Void {
        throw "Not implemented";
    }

    /**
     * Read bytes from channel
     * @return Bytes
     */
    public function read():Bytes {
        throw "Not implemented";
    }
}