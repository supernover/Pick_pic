import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/widgets/login/components/my_loading_route.dart';

import '../puzzle_detail_page.dart';

/// puzzle image list item widget
class ItemCard extends StatelessWidget {
  const ItemCard(
      {this.openContainer,
      this.subtitle,
      required this.id,
      required this.index,
      required this.imageUrl});

  final VoidCallback? openContainer;

  /// image subtitle,disable now
  final String? subtitle;

  /// this is puzzleImage model ID,a documentID,get from firebase
  /// use for hero animation
  final String id;

  /// current item index
  final int index;

  /// image url
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _buildBody(context, size);
  }

  /// main widget
  Widget _buildBody(BuildContext context, Size size) {
    return GestureDetector(
      key: ValueKey(id),
      onTap: () {
        Navigator.push<void>(
            context,
            MyLoadingRoute<void>(
                duration: Duration(milliseconds: 500),
                builder: (context) => PuzzleDetailsPage(
                      imageUrl: imageUrl,
                      id: id,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildIcon(context), _buildInfo(context)],
              ),
            ),
            _buildImage(context, size)
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(smallPadding),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: index % 2 == 0 ? Colors.blue : Colors.yellow,
                    blurRadius: 15.0,
                  ),
                ]),
            // margin:
            //     EdgeInsets.only(left: verySmallPadding, top: verySmallPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 6,
                  width: MediaQuery.of(context).size.width / 6,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/bg/waifu.jpg'),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(right: smallPadding),
                    child: Text(
                      'UserName',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// image widget with a hero animation
  Widget _buildImage(BuildContext context, Size size) {
    return Hero(
      tag: '$id',
      child: Container(
        width: size.width / 2,
        height: size.width / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            // topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
            // bottomLeft: const Radius.circular(15.0),
            bottomRight: const Radius.circular(15.0),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                Image.asset('assets/images/placeholder.png'),
            errorWidget: (context, url, dynamic e) => Icon(Icons.error),
          ),

          // Image.memory(
          //   bytes,
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 8),
          Text(
            'this is subtitle about the puzzle ',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
