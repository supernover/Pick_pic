import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'resources/test') {
      return ByteData.view(Uint8List.fromList(utf8.encode('Hello World!')).buffer);
    }
    return ByteData(0);
  }
}