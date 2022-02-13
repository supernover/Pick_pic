import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/l10n/test_res.dart';

import '../../my_app.dart';

class UserInfoPage extends StatefulWidget {
  final User? user;

  const UserInfoPage({Key? key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserInfoState(
        user,
      );
}

class UserInfoState extends State<UserInfoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final User? user;

  UserInfoState(this.user);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _buildBody(context, size),
    );
  }

  Column _buildBody(BuildContext context, Size size) {
    return Column(
      children: [
        _buildTitle(context,
            '${user == null ? '${TextResource.mockUserName(context)}' : user!.displayName}'),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: mediumPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildIcon(size),
                    Spacer(),
                    Container(
                      width: size.width / 2,
                      margin: EdgeInsets.only(right: bigPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildText(
                              '0', '${TextResource.userInfoPuzzle(context)}'),
                          _buildText(
                              '0', '${TextResource.userInfoFriend(context)}'),
                          _buildText('0',
                              '${TextResource.userInfoPuzzleLike(context)}'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                width: size.width,
                height: size.width / 3,
                padding: EdgeInsets.only(left: smallPadding),
                child: Row(
                  children: [_buildDarkModeSwitch(context)],
                ),
              ),
              Center(
                child: Text('${TextResource.userInfoNoneText(context)}'),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildDarkModeSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wb_sunny,
          color: Theme.of(context).accentColor,
        ),
        Container(
          child: Consumer(
            builder: (context, watch, _) {
              return Switch(
                value: watch(DarkModeProvider).state,
                onChanged: (value) {
                  context.read(DarkModeProvider).state = value;
                },
                inactiveThumbColor: Theme.of(context).primaryColor,
                inactiveTrackColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).accentColor,
                activeTrackColor: Theme.of(context).accentColor,
              );
            },
          ),
        ),
        Icon(
          Icons.nightlight_round,
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  Widget _buildText(String title, String value) {
    return Column(children: [
      Text('$title',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor)),
      Text('$value',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _buildIcon(Size size) {
    return Container(
      margin: EdgeInsets.only(left: mediumPadding),
      height: bigSize,
      width: bigSize,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(user != null
                  ? user!.photoURL!
                  : 'https://spng.pngfind.com/pngs/s/125-1256363_post-anime-girl-icon-transparent-hd-png-download.png')),
          color: Theme.of(context).accentColor,
          shape: BoxShape.circle),
    );
  }

  Widget _buildTitle(BuildContext context, String useName) {
    return Container(
      margin: EdgeInsets.only(
          top: mediumText * 2, left: mediumPadding, right: mediumPadding),
      child: Row(
        children: [
          Text(
            '$useName',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          SvgPicture.asset('assets/icons/menu.svg', width: mediumSize),
          SizedBox(
            width: mediumPadding,
          ),
          SvgPicture.asset('assets/icons/plus.svg', width: mediumSize)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
