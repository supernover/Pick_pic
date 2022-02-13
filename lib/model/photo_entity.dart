import 'package:pick_pic/generated/json/base/json_convert_content.dart';
import 'package:pick_pic/generated/json/base/json_field.dart';

class PhotoEntity with JsonConvert<PhotoEntity> {
  late String id;
  @JSONField(name: 'created_at')
  late String createdAt;
  @JSONField(name: 'updated_at')
  late String updatedAt;
  late double width;
  late double height;
  late String color;
  @JSONField(name: 'blur_hash')
  late String blurHash;
  late double likes;
  @JSONField(name: 'liked_by_user')
  late bool likedByUser;
  late String description;
  late PhotoUser user;
  @JSONField(name: 'current_user_collections')
  late List<PhotoCurrentUserCollections> currentUserCollections;
  late PhotoUrls urls;
  late PhotoLinks links;
}

class PhotoUser with JsonConvert<PhotoUser> {
  late String id;
  late String username;
  late String name;
  @JSONField(name: 'portfolio_url')
  late String portfolioUrl;
  late String bio;
  late String location;
  @JSONField(name: 'total_likes')
  late double totalLikes;
  @JSONField(name: 'total_photos')
  late double totalPhotos;
  @JSONField(name: 'total_collections')
  late double totalCollections;
  @JSONField(name: 'instagram_username')
  late String instagramUsername;
  @JSONField(name: 'twitter_username')
  late String twitterUsername;
  @JSONField(name: 'profile_image')
  late PhotoUserProfileImage profileImage;
  late PhotoUserLinks links;
}

class PhotoUserProfileImage with JsonConvert<PhotoUserProfileImage> {
  late String small;
  late String medium;
  late String large;
}

class PhotoUserLinks with JsonConvert<PhotoUserLinks> {
  late String self;
  late String html;
  late String photos;
  late String likes;
  late String portfolio;
}

class PhotoCurrentUserCollections
    with JsonConvert<PhotoCurrentUserCollections> {
  late double id;
  late String title;
  @JSONField(name: 'published_at')
  late String publishedAt;
  @JSONField(name: 'last_collected_at')
  late String lastCollectedAt;
  @JSONField(name: 'updated_at')
  late String updatedAt;
  @JSONField(name: 'cover_photo')
  late dynamic coverPhoto;
  late dynamic user;
}

class PhotoUrls with JsonConvert<PhotoUrls> {
  late String raw;
  late String full;
  late String regular;
  late String small;
  late String thumb;
}

class PhotoLinks with JsonConvert<PhotoLinks> {
  late String self;
  late String html;
  late String download;
  @JSONField(name: 'download_location')
  late String downloadLocation;
}
