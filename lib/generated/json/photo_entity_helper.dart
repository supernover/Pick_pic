import 'package:pick_pic/model/photo_entity.dart';

PhotoEntity photoEntityFromJson(PhotoEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id'].toString();
  }
  if (json['created_at'] != null) {
    data.createdAt = json['created_at'].toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at'].toString();
  }
  if (json['width'] != null) {
    data.width = (json['width'] is String
        ? double.tryParse(json['width'] as String)
        : json['width'].toDouble()) as double;
  }
  if (json['height'] != null) {
    data.height = (json['height'] is String
        ? double.tryParse(json['height'] as String)
        : json['height'].toDouble()) as double;
  }
  if (json['color'] != null) {
    data.color = json['color'].toString();
  }
  if (json['blur_hash'] != null) {
    data.blurHash = json['blur_hash'].toString();
  }
  if (json['likes'] != null) {
    data.likes = (json['likes'] is String
        ? double.tryParse(json['likes'] as String)
        : json['likes'].toDouble()) as double;
  }
  if (json['liked_by_user'] != null) {
    data.likedByUser = (json['liked_by_user']) as bool;
  }
  if (json['description'] != null) {
    data.description = json['description'].toString();
  }
  if (json['user'] != null) {
    data.user = PhotoUser().fromJson(json['user'] as Map<String, dynamic>);
  }
  if (json['current_user_collections'] != null) {
    data.currentUserCollections = (json['current_user_collections'] as List)
        .map((dynamic v) =>
            PhotoCurrentUserCollections().fromJson(v as Map<String, dynamic>))
        .toList();
  }
  if (json['urls'] != null) {
    data.urls = PhotoUrls().fromJson(json['urls'] as Map<String, dynamic>);
  }
  if (json['links'] != null) {
    data.links = PhotoLinks().fromJson(json['links'] as Map<String, dynamic>);
  }
  return data;
}

Map<String, dynamic> photoEntityToJson(PhotoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['width'] = entity.width;
  data['height'] = entity.height;
  data['color'] = entity.color;
  data['blur_hash'] = entity.blurHash;
  data['likes'] = entity.likes;
  data['liked_by_user'] = entity.likedByUser;
  data['description'] = entity.description;
  data['user'] = entity.user.toJson();
  data['current_user_collections'] =
      entity.currentUserCollections.map((v) => v.toJson()).toList();
  data['urls'] = entity.urls.toJson();
  data['links'] = entity.links.toJson();
  return data;
}

PhotoUser photoUserFromJson(PhotoUser data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id'].toString();
  }
  if (json['username'] != null) {
    data.username = json['username'].toString();
  }
  if (json['name'] != null) {
    data.name = json['name'].toString();
  }
  if (json['portfolio_url'] != null) {
    data.portfolioUrl = json['portfolio_url'].toString();
  }
  if (json['bio'] != null) {
    data.bio = json['bio'].toString();
  }
  if (json['location'] != null) {
    data.location = json['location'].toString();
  }
  if (json['total_likes'] != null) {
    data.totalLikes = (json['total_likes'] is String
        ? double.tryParse(json['total_likes'] as String)
        : json['total_likes'].toDouble()) as double;
  }
  if (json['total_photos'] != null) {
    data.totalPhotos = (json['total_photos'] is String
        ? double.tryParse(json['total_photos'] as String)
        : json['total_photos'].toDouble()) as double;
  }
  if (json['total_collections'] != null) {
    data.totalCollections = (json['total_collections'] is String
        ? double.tryParse(json['total_collections'] as String)
        : json['total_collections'].toDouble()) as double;
  }
  if (json['instagram_username'] != null) {
    data.instagramUsername = json['instagram_username'].toString();
  }
  if (json['twitter_username'] != null) {
    data.twitterUsername = json['twitter_username'].toString();
  }
  if (json['profile_image'] != null) {
    data.profileImage = PhotoUserProfileImage()
        .fromJson(json['profile_image'] as Map<String, dynamic>);
  }
  if (json['links'] != null) {
    data.links =
        PhotoUserLinks().fromJson(json['links'] as Map<String, dynamic>);
  }
  return data;
}

Map<String, dynamic> photoUserToJson(PhotoUser entity) {
  final data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['name'] = entity.name;
  data['portfolio_url'] = entity.portfolioUrl;
  data['bio'] = entity.bio;
  data['location'] = entity.location;
  data['total_likes'] = entity.totalLikes;
  data['total_photos'] = entity.totalPhotos;
  data['total_collections'] = entity.totalCollections;
  data['instagram_username'] = entity.instagramUsername;
  data['twitter_username'] = entity.twitterUsername;
  data['profile_image'] = entity.profileImage.toJson();
  data['links'] = entity.links.toJson();
  return data;
}

PhotoUserProfileImage photoUserProfileImageFromJson(
    PhotoUserProfileImage data, Map<String, dynamic> json) {
  if (json['small'] != null) {
    data.small = json['small'].toString();
  }
  if (json['medium'] != null) {
    data.medium = json['medium'].toString();
  }
  if (json['large'] != null) {
    data.large = json['large'].toString();
  }
  return data;
}

Map<String, dynamic> photoUserProfileImageToJson(PhotoUserProfileImage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['small'] = entity.small;
  data['medium'] = entity.medium;
  data['large'] = entity.large;
  return data;
}

PhotoUserLinks photoUserLinksFromJson(
    PhotoUserLinks data, Map<String, dynamic> json) {
  if (json['self'] != null) {
    data.self = json['self'].toString();
  }
  if (json['html'] != null) {
    data.html = json['html'].toString();
  }
  if (json['photos'] != null) {
    data.photos = json['photos'].toString();
  }
  if (json['likes'] != null) {
    data.likes = json['likes'].toString();
  }
  if (json['portfolio'] != null) {
    data.portfolio = json['portfolio'].toString();
  }
  return data;
}

Map<String, dynamic> photoUserLinksToJson(PhotoUserLinks entity) {
  final data = <String, dynamic>{};
  data['self'] = entity.self;
  data['html'] = entity.html;
  data['photos'] = entity.photos;
  data['likes'] = entity.likes;
  data['portfolio'] = entity.portfolio;
  return data;
}

PhotoCurrentUserCollections photoCurrentUserCollectionsFromJson(
    PhotoCurrentUserCollections data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = (json['id'] is String
        ? double.tryParse(json['id'] as String)
        : json['id'].toDouble()) as double;
  }
  if (json['title'] != null) {
    data.title = json['title'].toString();
  }
  if (json['published_at'] != null) {
    data.publishedAt = json['published_at'].toString();
  }
  if (json['last_collected_at'] != null) {
    data.lastCollectedAt = json['last_collected_at'].toString();
  }
  if (json['updated_at'] != null) {
    data.updatedAt = json['updated_at'].toString();
  }
  if (json['cover_photo'] != null) {
    data.coverPhoto = json['cover_photo'];
  }
  if (json['user'] != null) {
    data.user = json['user'];
  }
  return data;
}

Map<String, dynamic> photoCurrentUserCollectionsToJson(
    PhotoCurrentUserCollections entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['published_at'] = entity.publishedAt;
  data['last_collected_at'] = entity.lastCollectedAt;
  data['updated_at'] = entity.updatedAt;
  data['cover_photo'] = entity.coverPhoto;
  data['user'] = entity.user;
  return data;
}

PhotoUrls photoUrlsFromJson(PhotoUrls data, Map<String, dynamic> json) {
  if (json['raw'] != null) {
    data.raw = json['raw'].toString();
  }
  if (json['full'] != null) {
    data.full = json['full'].toString();
  }
  if (json['regular'] != null) {
    data.regular = json['regular'].toString();
  }
  if (json['small'] != null) {
    data.small = json['small'].toString();
  }
  if (json['thumb'] != null) {
    data.thumb = json['thumb'].toString();
  }
  return data;
}

Map<String, dynamic> photoUrlsToJson(PhotoUrls entity) {
  final data = <String, dynamic>{};
  data['raw'] = entity.raw;
  data['full'] = entity.full;
  data['regular'] = entity.regular;
  data['small'] = entity.small;
  data['thumb'] = entity.thumb;
  return data;
}

PhotoLinks photoLinksFromJson(PhotoLinks data, Map<String, dynamic> json) {
  if (json['self'] != null) {
    data.self = json['self'].toString();
  }
  if (json['html'] != null) {
    data.html = json['html'].toString();
  }
  if (json['download'] != null) {
    data.download = json['download'].toString();
  }
  if (json['download_location'] != null) {
    data.downloadLocation = json['download_location'].toString();
  }
  return data;
}

Map<String, dynamic> photoLinksToJson(PhotoLinks entity) {
  final data = <String, dynamic>{};
  data['self'] = entity.self;
  data['html'] = entity.html;
  data['download'] = entity.download;
  data['download_location'] = entity.downloadLocation;
  return data;
}
