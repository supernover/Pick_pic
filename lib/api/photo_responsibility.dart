import 'package:pick_pic/generated/json/base/json_convert_content.dart';
import 'package:pick_pic/model/photo_entity.dart';
import 'package:pick_pic/model/search_photo_entity.dart';
import 'dio/dio_manager.dart';

/// manage unsplash API
class PhotoResponsibility {
  static final PhotoResponsibility _instance = PhotoResponsibility._internal();

  factory PhotoResponsibility() => _instance;

  PhotoResponsibility._internal();

  /// fetchPhotos  GET /photos
  /// https://unsplash.com/documentation#search-photos
  /// page: Page number to retrieve. (Optional; default: 1)
  /// order_by: How to sort the photos. (Optional; default: relevant). Valid values are latest and relevant.
  /// per_page: Number of items per page. (Optional; default: 10)
  Future<List<PhotoEntity>> fetchPhotos(
      {required int page, int? per_page, String? order_by}) async {
    Map<String, dynamic> params = <String, dynamic>{
      'page': page,
      'per_page': per_page ?? 10,
      'order_by': order_by ?? 'position'
    };

    var response = await DioManager().get('/photos', params: params);
    List<PhotoEntity> list = JsonConvert.fromJsonAsT(response);
    return list;
  }

  ///searchPhotos  GET /search/photos
  ///https://unsplash.com/documentation#search-photos
  /// query: Search terms
  /// page: Page number to retrieve. (Optional; default: 1)
  /// order_by: How to sort the photos. (Optional; default: relevant). Valid values are latest and relevant.
  /// per_page: Number of items per page. (Optional; default: 10)
  Future<List<PhotoEntity>> searchPhotos(
      {required int page,
      required String query,
      int? per_page,
      String? order_by}) async {
    if (query == '') {
      Map<String, dynamic> params = <String, dynamic>{
        'page': page,
        'per_page': per_page ?? 10,
        'order_by': order_by ?? 'position'
      };

      var response = await DioManager().get('/photos', params: params);
      List<PhotoEntity> list = JsonConvert.fromJsonAsT(response);
      return list;
    } else {
      Map<String, dynamic> params = <String, dynamic>{
        'page': page,
        'query': query,
        'per_page': per_page ?? 10,
        'order_by': order_by ?? 'position'
      };

      var response = await DioManager().get('/search/photos', params: params);
      SearchPhotoEntity searchPhotoEntity = JsonConvert.fromJsonAsT(response);

      return searchPhotoEntity.results;
    }
  }
}
