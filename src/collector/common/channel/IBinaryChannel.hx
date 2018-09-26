package collector.common.channel;

import haxe.io.Bytes;
/**
 * Channel with binary data transfer
 */
interface IBinaryChannel {
    /**
     * Write bytes
     * @param data 
     */
    function write(data:Bytes):Void;

    /**
     * Read bytes from channel
     * @return Bytes
     */
    function read():Bytes;
}