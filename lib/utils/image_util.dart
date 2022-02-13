import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// use for manage image tool
class ImageUtil {
  /// base64 to bytes
  static Uint8List b64ToImage(String b64) {
    Uint8List bytes = Base64Decoder().convert(b64);
    return bytes;
  }

  /// image path to bytes
  static Future<Uint8List> pathToImage(String path) async {
    File file = File(path);

    Uint8List bytes = await compressFile(file, 50);

    return bytes;
  }

  /// compress Image
  /// quality : quality
  static Future<Uint8List> compressFile(File file, int quality) async {
    Uint8List? result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: quality,
    );

    return result!;
  }

  /// image url to bytes
  /// use http download....
  static Future<Uint8List> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return bytes;
  }
}
