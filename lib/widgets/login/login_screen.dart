import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/components/my_common_button.dart';
import 'package:pick_pic/l10n/test_res.dart';
import '../main/main_page.dart';
import 'components/my_loading_route.dart';
import 'components/my_login_button.dart';

final loginModeProvider = StateProvider((ref) => false);

/// login page
/// use GoogleSign
/// you can login without any auth by test
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  /// use for loading hero animation
  static int loginTag = 0001;

  /// use for googleSign
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final StreamController<User> _authStreamController =
      StreamController<User>.broadcast();

  /// login action
  Future<void> _handleLogin(BuildContext context) async {
    await Firebase.initializeApp();
    if (!context.read(loginModeProvider).state) {
      GoogleSignInAccount? googleCurrentUser = _googleSignIn.currentUser;

      googleCurrentUser ??= await _googleSignIn.signInSilently();
      googleCurrentUser ??= await _googleSignIn.signIn();
      if (googleCurrentUser == null) {
        return null;
      }

      GoogleSignInAuthentication googleAuth =
          await googleCurrentUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = (await _auth.signInWithCredential(credential)).user;
      _authStreamController.add(user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: loginColor,
      body: _buildBody(size, context),
    );
  }

  /// main widget
  Widget _buildBody(Size size, BuildContext context) {
    return Container(
      key: Key('body'),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(context, size),
          _buildSwitch(context),
          _buildButton(context, size)
        ],
      ),
    );
  }

  /// login button
  Widget _buildButton(BuildContext context, Size size) {
    return Container(
      key: Key('loginButton'),
      margin: EdgeInsets.only(top: mediumPadding),
      child: MyCommonButton(
        text: '${TextResource.loginText(context)}',
        press: () {
          Navigator.push(
              context,
              MyLoadingRoute<void>(
                  duration: Duration(milliseconds: 300),
                  color: yPrimaryColor,
                  builder: (BuildContext context) {
                    _handleLogin(context);
                    return Center(
                      child: Container(
                        width: size.width,
                        height: size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Hero(
                                  tag: '$loginTag',
                                  child: SvgPicture.asset(
                                      'assets/icons/profile_user.svg')),
                            ),
                            MyLoginButton(
                              loginTag: loginTag,
                              stream: _authStreamController.stream,
                            )
                          ],
                        ),
                      ),
                    );
                  }));
        },
      ),
    );
  }

  /// switch login mode  googleAuth || test
  Widget _buildSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${TextResource.authModeText(context)}',
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(
          child: Consumer(
            builder: (context, watch, _) {
              return Switch(
                value: watch(loginModeProvider).state,
                onChanged: (value) {
                  context.read(loginModeProvider).state = value;
                },
                inactiveThumbColor: Theme.of(context).shadowColor,
                inactiveTrackColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).shadowColor,
                activeTrackColor: Theme.of(context).accentColor,
              );
            },
          ),
        ),
        Text(
          '${TextResource.testModeText(context)}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context, Size size) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Theme.of(context).accentColor.withOpacity(0.2))
      ]),
      height: size.height / 8,
      width: size.height / 8,
      child: Hero(
          tag: '$loginTag',
          child: SvgPicture.asset('assets/icons/profile_user.svg')),
    );
  }
}
