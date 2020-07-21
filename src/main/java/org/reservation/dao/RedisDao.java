package org.reservation.dao;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtostuffIOUtil;
import com.dyuproject.protostuff.runtime.RuntimeSchema;
import org.reservation.entity.Room;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 应用缓存应对高并发场景
 */
public class RedisDao {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private final JedisPool jedisPool;

    private final RuntimeSchema<Room> schema = RuntimeSchema.createFrom(Room.class);

    public RedisDao(String ip, int port) {
        this.jedisPool = new JedisPool(ip, port);
    }

    /**
     * 从redis中根据roomId获取对象
     */
    public Room getRoom(int roomId) {
        try (Jedis jedis = jedisPool.getResource()) {
            String key = "room:" + roomId;
            byte[] bytes = jedis.get(key.getBytes());
            if (bytes != null) {
                Room room = schema.newMessage();
                ProtostuffIOUtil.mergeFrom(bytes, room, schema);
                return room;
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将room对象序列化之后放入redis
     */
    public String putRoom(Room room) {
        try (Jedis jedis = jedisPool.getResource()) {
            String key = "room:" + room.getRoomId();
            byte[] bytes = ProtostuffIOUtil.toByteArray(room, schema,
                    LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE));
            int timeout = 300;
            return jedis.setex(key.getBytes(), timeout, bytes);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }
}