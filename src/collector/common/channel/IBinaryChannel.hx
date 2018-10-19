package collector.common.channel;

import core.async.stream.Stream;
import haxe.io.Bytes;

/**
 * Channel with binary data transfer
 */
interface IBinaryChannel {
    /**
     * Data stream
     */
    var onData(default, never):Stream<Bytes>;

    /**
     * Write bytes
     * @param data 
     */
    function write(data:Bytes):Void;    
}