import 'package:pick_pic/generated/json/base/json_convert_content.dart';
import 'package:pick_pic/generated/json/base/json_field.dart';
import 'package:pick_pic/model/photo_entity.dart';

class SearchPhotoEntity with JsonConvert<SearchPhotoEntity> {
  late int total;
  @JSONField(name: 'total_pages')
  late int totalPages;
  late List<PhotoEntity> results;
}
