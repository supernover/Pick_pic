import 'dart:io';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/widgets/game/display_picture_page.dart';
import 'package:pick_pic/widgets/photo/photo_list_page.dart';
import 'package:pick_pic/widgets/puzzle/puzzle_list_page.dart';
import 'package:pick_pic/widgets/user/user_info_page.dart';

final tabBarIndexProvider = StateProvider((ref) => 0);

/// main page
class MainPage extends StatelessWidget {
  final int? heroTag;
  final User? user;
  final picker = ImagePicker();

  /// use for switch FabCircularMenu open/close
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  MainPage({Key? key, this.heroTag, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PuzzleListPage(),
              PhotoListPage(),
              UserInfoPage(user: user),
            ],
          ),
          floatingActionButton: Consumer(
            builder: (context, watch, _) {
              if (watch(tabBarIndexProvider).state == 2) {
                return SizedBox(
                  width: 1,
                  height: 1,
                );
              }
              return buildFloatingActionButton(context, size);
            },
          ),
          bottomNavigationBar: buildBottomNavigationBar(context),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: mediumPadding, top: smallPadding),
      child: Container(
        // color: Colors.black,
        child: TabBar(
          onTap: (int index) {
            context.read(tabBarIndexProvider).state = index;
          },
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.search_rounded),
            ),
            Tab(
              icon: Hero(
                  tag: '$heroTag',
                  child: Container(
                    height: mediumSize,
                    width: mediumSize,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user != null
                                ? user!.photoURL!
                                : 'https://spng.pngfind.com/pngs/s/125-1256363_post-anime-girl-icon-transparent-hd-png-download.png')),
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle),
                  )),
            )
          ],
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Theme.of(context).accentColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(verySmallPadding),
          indicatorColor: Colors.transparent,
        ),
      ),
    );
  }

  /// a button with a menu {take photo || use library}
  FabCircularMenu buildFloatingActionButton(BuildContext context, Size size) {
    return FabCircularMenu(
        key: fabKey,
        ringDiameter: size.width * 2 / 3,
        ringColor: Colors.transparent,
        fabOpenColor: Theme.of(context).primaryColor,
        fabCloseColor: Theme.of(context).primaryColor,
        fabOpenIcon: Icon(
          Icons.camera_alt,
          color: Theme.of(context).accentColor,
        ),
        fabCloseIcon: Icon(
          Icons.clear,
        ),
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.camera,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (fabKey.currentState!.isOpen) {
                  fabKey.currentState!.close();
                }
                getCamera(context);
              }),
          IconButton(
              icon: Icon(
                Icons.photo_library,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                if (fabKey.currentState!.isOpen) {
                  fabKey.currentState!.close();
                }
                getGallery(context);
              }),
        ]);
  }

  /// go to camera,need permission
  Future<void> getCamera(BuildContext context) async {
    await picker.getImage(source: ImageSource.camera).then((value) {
      cropper(context, value!.path).then((value) {
        if (value != null) {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DisplayPicturePage(imagePath: value.path.toString()),
            ),
          );
        }
      });
    });
  }

  /// go to library,need permission
  Future<void> getGallery(BuildContext context) async {
    await picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        cropper(context, value.path).then((value) {
          if (value != null) {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPicturePage(imagePath: value.path.toString()),
              ),
            );
          }
        });
      }
    });
  }

  /// get image from camera or library,then crop it for use
  Future<File?> cropper(BuildContext context, String path) async {
    return await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Theme.of(context).primaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }
}
