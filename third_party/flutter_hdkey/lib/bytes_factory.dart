import 'dart:typed_data';

class BytesFactory {
  BytesFactory(int length, Endian endian) {
    _endian = endian;
    _bytes = Uint8List(length);
    _data = ByteData.view(_bytes.buffer);
  }

  int _position = 0; // 参数set position
  Endian _endian;
  Uint8List _bytes;
  ByteData _data;

  BytesFactory setInt(int value) {
    _data.setInt32(_position, value, _endian);
    _position += 4;
    return this;
  }

  BytesFactory setByte(int value) {
    _data.setUint8(_position, value);
    _position += 1;

    return this;
  }

  BytesFactory setBytes(List<int> value) {
    for (final item in value) {
      setByte(item);
    }
    return this;
  }

  Uint8List build() {
    return _bytes;
  }
}
