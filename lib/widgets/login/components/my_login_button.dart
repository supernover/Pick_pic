import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/l10n/test_res.dart';
import 'package:pick_pic/widgets/main/main_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../login_screen.dart';
import 'my_loading_route.dart';

class MyLoginButton extends StatelessWidget {
  final int loginTag;
  final Stream<User> stream;

  const MyLoginButton({Key? key, required this.loginTag, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(smallPadding),
        child: StreamBuilder<User>(
            stream: stream,
            builder: (context, snapshot) {
              /// this is test mode without firebase auth
              if (context.read(loginModeProvider).state) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((timeStamp) async {
                  /// mock loading
                  await Future<void>.delayed(const Duration(seconds: 1));
                  await Navigator.pushReplacement(
                      context,
                      MyLoadingRoute<void>(
                          duration: Duration(milliseconds: 500),
                          builder: (context) => MainPage(
                                heroTag: loginTag,
                                user: null,
                              )));
                });
                // custom loading text view
                return widgetLoginSuccess(context);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                // change loading text view
                return widgetLoading();
              } else if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.data != null ||
                  snapshot.data == null) {
                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                  Navigator.pushReplacement(
                      context,
                      MyLoadingRoute<void>(
                          duration: Duration(milliseconds: 500),
                          builder: (context) => MainPage(
                                heroTag: loginTag,
                                user: snapshot.data,
                              )));
                });
                // custom loading text view
                return widgetLoginSuccess(context);
              } else {
                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop();
                });
              }
              return Container();
            }),
      ),
    );
  }

  AnimatedDefaultTextStyle widgetLoginSuccess(BuildContext context) {
    return AnimatedDefaultTextStyle(
        key: Key('loginSuccess'),
        duration: Duration(milliseconds: 300),
        style: TextStyle(fontSize: mediumText),
        child: Text(
          '${TextResource.loginSuccessText(context)}',
        ));
  }

  AnimatedDefaultTextStyle widgetLoading() {
    return AnimatedDefaultTextStyle(
        key: Key('loginLoading'),
        duration: Duration(milliseconds: 300),
        style: TextStyle(fontSize: mediumText - 5.0),
        child: Text(
          'Loading...',
        ));
  }
}
