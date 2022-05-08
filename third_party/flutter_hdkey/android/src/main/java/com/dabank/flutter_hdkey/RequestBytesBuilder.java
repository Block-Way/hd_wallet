package com.dabank.flutter_hdkey;


import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.List;

class RequestBytesBuilder {
    private ByteOrder order; // 排序
    private int length; // 数据包长度
    private int id; // 请求序号
    private byte tag; // 请求标识
    private int index; // 序号
    private int paramsLength;// 参数长度
    private List<byte[]> params; // 参数

    RequestBytesBuilder() {
        this.order = ByteOrder.LITTLE_ENDIAN; // 排序，默认小端序
        this.length = 14; // 数据包长度 默认为14（数据包长度+请求序号+请求标识+接口参数长度+序号）（4+4+1+4+1 = 14）
        this.id = (int) (System.currentTimeMillis() / 1000L); // 请求序号 默认当前时间（秒）
        this.tag = (byte) 0;
        this.index = (byte) 0;
        this.paramsLength = 1; // 参数长度 默认为1（序号）
        this.params = new ArrayList<>();
    }

    /**
     * 设置排序规则
     *
     * @param order 排序
     * @return this
     */
    RequestBytesBuilder setOrder(ByteOrder order) {
        this.order = order;
        return this;
    }

    /**
     * 设置请求序号
     *
     * @param id 请求序号
     * @return this
     */
    RequestBytesBuilder setId(int id) {
        this.id = id;
        return this;
    }

    /**
     * 设置请求标识
     *
     * @param tag 请求标识
     * @return this
     */
    RequestBytesBuilder setTag(byte tag) {
        this.tag = tag;
        return this;
    }

    /**
     * 设置序号
     *
     * @param index 序号
     * @return this
     */
    RequestBytesBuilder setIndex(int index) {
        this.index = index;
        return this;
    }

    /**
     * 添加参数
     *
     * @param bytes 参数
     * @return this
     */
    RequestBytesBuilder addParams(byte[] bytes) {
        this.length += bytes.length;
        this.paramsLength += bytes.length;
        this.params.add(bytes);
        return this;
    }

    byte[] build() {
        ByteBuffer buf = ByteBuffer
                .allocate(length) // 请求包长度
                .order(order) // 必须是小端序
                .putInt(length) // 数据包长度 4
                .putInt(id) // 请求序号 4
                .put(tag) // 接口标识 1
                .putInt(paramsLength) // 接口参数长度 4
                .put((byte) this.index); // 钱包序号 1
        for (byte[] bytes : params) {
            buf.put(bytes);
        }
        return buf.array();
    }

    byte[] build(boolean noIndex) {
        if (noIndex) {
            this.length -= 1;
            this.paramsLength -= 1;
        }

        ByteBuffer buf = ByteBuffer
                .allocate(length) // 请求包长度
                .order(order) // 必须是小端序
                .putInt(length) // 数据包长度 4
                .putInt(id) // 请求序号 4
                .put(tag) // 接口标识 1
                .putInt(paramsLength); // 接口参数长度 4

        if (!noIndex) {
            buf.put((byte) this.index); // 钱包序号 1
        }

        for (byte[] bytes : params) {
            buf.put(bytes);
        }
        return buf.array();
    }
}