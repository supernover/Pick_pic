import 'package:pick_pic/model/photo_entity.dart';
import 'package:pick_pic/model/search_photo_entity.dart';

SearchPhotoEntity searchPhotoEntityFromJson(
    SearchPhotoEntity data, Map<String, dynamic> json) {
  if (json['total'] != null) {
    data.total = json['total'] is String
        ? int.tryParse(json['total'] as String)!
        : json['total'].toInt() as int;
  }
  if (json['total_pages'] != null) {
    data.totalPages = json['total_pages'] is String
        ? int.tryParse(json['total_pages'] as String)!
        : json['total_pages'].toInt() as int;
  }
  if (json['results'] != null) {
    data.results = (json['results'] as List)
        .map((v) => PhotoEntity().fromJson(v as Map<String, dynamic>))
        .toList();
  }
  return data;
}
