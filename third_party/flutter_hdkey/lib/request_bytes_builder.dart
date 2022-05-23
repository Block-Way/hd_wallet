import 'dart:typed_data';
import 'package:flutter_hdkey/bytes_factory.dart';
import 'package:flutter_hdkey/flutter_hdkey.dart';

class RequestBytesBuilder {
  RequestBytesBuilder() {
    _endian = Endian.little; // 排序，默认小端序
    _headerLength = 4 + 4 + 1 + 4 + 1; //数据包长度4+请求序号4+请求标识1+接口参数长度4+序号1
    _id = DateTime.now().millisecondsSinceEpoch; // 请求序号 默认当前时间（秒）
    _tag = 0;
    _index = 0;
    _paramsLength = 0;
    _params = <List<int>>[];
  }

  Endian _endian; // 排序
  int _headerLength; // 数据包长度
  int _id; // 请求序号
  int _tag; // 请求标识
  int _index; // 序号
  int _paramsLength; // 参数长度
  List<List<int>> _params; // 参数

  /// 设置排序规则
  RequestBytesBuilder setEndian(Endian endian) {
    _endian = endian;
    return this;
  }

  /// 设置请求序号
  RequestBytesBuilder setId(int id) {
    _id = id;
    return this;
  }

  /// 设置请求标识
  RequestBytesBuilder setTag(int tag) {
    _tag = tag;
    return this;
  }

  /// 设置序号
  RequestBytesBuilder setIndex(int index) {
    _index = index;
    return this;
  }

  /// 添加参数
  RequestBytesBuilder addParams(List<int> data) {
    _paramsLength += data.length;
    _params.add(data);
    return this;
  }

  RequestBytesBuilder addIntParams(int value, [int count = 1]) {
    addParams(ByteUtils.intToBytes(value, count));
    return this;
  }

  RequestBytesBuilder addStrParams(String value) {
    addParams(ByteUtils.strToBytes(value));
    return this;
  }

  RequestBytesBuilder addHexParams(String value) {
    addParams(ByteUtils.hexToBytes(value));
    return this;
  }

  Uint8List build({bool noIndex = true}) {
    if (noIndex) {
      _headerLength -= 1;
    }
    final totalLength = _headerLength + _paramsLength;

    final bytesFactory = BytesFactory(totalLength, _endian)
        .setInt(totalLength) //数据包长度4
        .setInt(_id) //请求序号4
        .setByte(_tag) //请求标识1
        .setInt(_paramsLength); //接口参数长度4

    if (!noIndex) {
      bytesFactory.setByte(_index);
    }

    for (final item in _params) {
      bytesFactory.setBytes(item);
    }

    return bytesFactory.build();
  }
}
