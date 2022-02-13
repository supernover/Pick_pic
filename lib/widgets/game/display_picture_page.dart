import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pick_pic/api/firebase/cloud_manager.dart';
import 'package:pick_pic/api/firebase/firebase_storage_manager.dart';
import 'package:pick_pic/components/my_circle_button.dart';
import 'package:pick_pic/states/provider/puzzle/puzzle_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:pick_pic/utils/image_util.dart';
import 'package:pick_pic/widgets/puzzle/puzzle_play_page.dart';

/// display a cropped image
class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  DisplayPicturePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text('Display the Picture')),
      body: Stack(
        children: [
          Container(
              width: size.width,
              height: size.height,
              child: Image.file(File(imagePath), fit: BoxFit.cover)),
          _buildBody(size, context),
        ],
      ),
    );
  }

  Widget _buildBody(Size size, BuildContext context) {
    return Container(
      key: Key('body'),
      color: Theme.of(context).accentColor.withOpacity(0.8),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.height / 4),
            width: size.width,
            height: size.width,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          _buildButton(size, context)
        ],
      ),
    );
  }

  Widget _buildButton(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height / 8),
      alignment: Alignment.center,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyCircleButton(
            key: Key('X'),
            width: size.width / 6,
            text: 'X',
            press: () {
              Navigator.pop(context, true);
            },
          ),
          MyCircleButton(
            key: Key('O'),
            width: size.width / 6,
            text: 'O',
            press: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).shadowColor.withOpacity(0.5),
                content: LinearProgressIndicator(
                    // color: Theme.of(context).accentColor,
                    ),
                // duration: const Duration(seconds: 1),
              ));
              uploadImage(context, imagePath);
            },
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage(BuildContext context, String imagePath) async {
    Uint8List bytes = await ImageUtil.pathToImage(imagePath);

    await FirebaseStorageManager()
        .uploadImageFile(imagePath, Random().nextInt(10000).toString())
        .then((value) {
      if (value != 'update error') {
        String imageUrl = value;
        DateTime now = DateTime.now();
        Map<String, dynamic> map = {'imageUrl': imageUrl, 'upLoadTime': now};
        CloudManager().setDataToFirebase(
            'user001', Random().nextInt(10000).toString(), map);
      }
      startGame(context, bytes);
    });
  }

  void startGame(BuildContext context, Uint8List bytes) {
    context.read(puzzleProvider.notifier).refresh();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PuzzlePlayPage(MediaQuery.of(context).size, bytes, 3)));
  }
}
