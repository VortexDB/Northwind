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
     * Read bytes from channel with timeout in milliseconds
     * @return Bytes
     */
    function read(?timeout:Int):Bytes;
}