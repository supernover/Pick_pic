import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pick_pic/model/photo_entity.dart';
import 'package:pick_pic/widgets/login/components/my_loading_route.dart';
import 'package:pick_pic/widgets/puzzle/puzzle_detail_page.dart';

/// photo list view item widget
class PhotoItem extends StatelessWidget {
  const PhotoItem(this.index, this.photoEntity);

  // photoModel
  final PhotoEntity photoEntity;

  // current item index
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: photoEntity.id,
      child: GestureDetector(
        onTap: () {
          Navigator.push<void>(
              context,
              MyLoadingRoute<void>(
                  duration: Duration(milliseconds: 500),
                  builder: (context) => PuzzleDetailsPage(
                        imageUrl: photoEntity.urls.regular,
                        // use id in photoEntity
                        id: photoEntity.id,
                      )));
        },
        child: CachedNetworkImage(
          width: size.width / 2 - 24,
          height:
              (size.width / 2 - 24) * (photoEntity.height / photoEntity.width),
          fit: BoxFit.cover,
          imageUrl: photoEntity.urls.regular,
          placeholder: (context, url) =>
              Image.asset('assets/images/placeholder.png'),
          errorWidget: (context, url, dynamic e) => Icon(Icons.error),
        ),
      ),
    );
  }
}
