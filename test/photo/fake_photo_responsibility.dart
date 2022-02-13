import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:pick_pic/api/photo_responsibility.dart';
import 'package:pick_pic/generated/json/base/json_convert_content.dart';
import 'package:pick_pic/model/photo_entity.dart';

import '../util/test_path.dart';

class FakePhotoRepository implements PhotoResponsibility {
  @override
  Future<List<PhotoEntity>> fetchPhotos(
      {required int page, int? per_page, String? order_by}) async {
    final String data =
        File(testPath('resources/test/get_success_response.json'))
            .readAsStringSync();
    List<PhotoEntity> list = JsonConvert.fromJsonAsT(json.decode(data));

    return list;
  }

  @override
  Future<List<PhotoEntity>> searchPhotos(
      {required int page,
      required String query,
      int? per_page,
      String? order_by}) {
    // TODO: implement searchPhotos
    throw UnimplementedError();
  }
}
