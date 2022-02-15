import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/components/my_circle_button.dart';
import 'package:pick_pic/utils/image_util.dart';
import 'puzzle_play_page.dart';
import '../login/components/my_loading_route.dart';

class PuzzleDetailsPage extends StatelessWidget {
  PuzzleDetailsPage(
      {this.includeMarkAsDoneButton = true,
      required this.id,
      required this.imageUrl});

  final bool includeMarkAsDoneButton;
  final String id;
  final String imageUrl;

  static int count = 0;

  final Stream newsStream =
      Stream.periodic(Duration(seconds: 2), (_) => count++);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              width: size.height,
              height: size.height,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    Image.asset('assets/images/placeholder.png'),
                errorWidget: (context, url, dynamic e) => Icon(Icons.error),
              )),
          _buildBody(context, size)
        ],
      ),
    );
  }

  List<Widget> _tips() {
    List<Widget> _tips = <Widget>[];

    return _tips;
  }

  Widget _buildBody(BuildContext context, Size size) {
    newsStream
        .map((e) {
          count = e as int;
          print(count);
          return 'stuff $e';
        })
        .take(5)
        .forEach((e) {
          print(e);
        });
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                _buildImage(context, size),
                Positioned(
                    top: 100,
                    left: 100,
                    child: Text(
                      'tips',
                      style: Theme.of(context).textTheme.bodyText1,
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: smallPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(size, context),
                  _buildBoard(context, size)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoard(BuildContext context, Size size) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFcec89f),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 6)),
            ],
          ),
          margin: EdgeInsets.only(top: size.width / 8),
          width: size.width / 3,
          height: size.width / 3,
          child: ListView(
            padding:
                EdgeInsets.only(top: 0.0, left: verySmallPadding, bottom: 0.0),
            children: [
              _buildRankItem(context, size),
              _buildRankItem(context, size),
              _buildRankItem(context, size),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(
                top: size.width / 10, left: size.width / 3 - 50),
            width: size.width / 12,
            height: size.width / 12,
            child: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: Colors.yellow,
            ))
      ],
    );
  }

  Widget _buildRankItem(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.only(top: mediumPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: size.width / 15,
            width: size.width / 15,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/bg/waifu.jpg'),
            ),
          ),
          Text(
            '00:00',
            style: TextStyle(
                fontSize: mediumText,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          )
        ],
      ),
    );
  }

  Widget _buildButton(Size size, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: size.width / 8),
        child: Stack(
          children: [
            Container(
              width: size.width / 2,
              height: size.width / 2,
              child: SvgPicture.asset('assets/icons/controller.svg'),
            ),
            Container(
              width: size.width / 2,
              height: size.width / 2,
              padding: EdgeInsets.only(top: size.width / 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyCircleButton(
                    width: size.width / 6,
                    text: 'Exit',
                    press: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  MyCircleButton(
                    width: size.width / 6,
                    text: 'Play',
                    press: () async {
                      Uint8List bytes =
                          await ImageUtil.networkImageToBase64(imageUrl);
                      await startGame(context, bytes);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, Size size) {
    return Hero(
      tag: '$id',
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.skewX(-0.05),
        child: Container(
          height: size.height * 0.6,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFFF0000), width: 0.5),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(10, -6)),
              ]),
          margin: EdgeInsets.only(
              top: veryBigPadding * 2, left: bigPadding, right: bigPadding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
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
      ),
    );
  }

  Future<void> startGame(BuildContext context, Uint8List bytes) async {
    await Navigator.push<void>(
        context,
        MyLoadingRoute<void>(
            duration: Duration(milliseconds: 500),
            builder: (context) =>
                PuzzlePlayPage(MediaQuery.of(context).size, bytes, 3)));
  }
}
