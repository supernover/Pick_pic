import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextResource {
  static final TextResource _instance = TextResource._internal();

  factory TextResource() => _instance;

  TextResource._internal();

  static String appName(BuildContext context) =>
      AppLocalizations.of(context)!.appName;

  static String mockUserName(BuildContext context) =>
      AppLocalizations.of(context)!.mockUserName;

  static String userInfoFriend(BuildContext context) =>
      AppLocalizations.of(context)!.userInfoFriend;

  static String userInfoPuzzle(BuildContext context) =>
      AppLocalizations.of(context)!.userInfoPuzzle;

  static String userInfoPuzzleLike(BuildContext context) =>
      AppLocalizations.of(context)!.userInfoPuzzleLike;

  static String userInfoNoneText(BuildContext context) =>
      AppLocalizations.of(context)!.userInfoNoneText;

  static String listNone(BuildContext context) =>
      AppLocalizations.of(context)!.listNone;


  static String loginText(BuildContext context) =>
      AppLocalizations.of(context)!.loginText;

  static String testModeText(BuildContext context) =>
      AppLocalizations.of(context)!.testText;

  static String authModeText(BuildContext context) =>
      AppLocalizations.of(context)!.authText;

  static String loginLoadingText(BuildContext context) =>
      AppLocalizations.of(context)!.loginLoadingText;

  static String loginSuccessText(BuildContext context) =>
      AppLocalizations.of(context)!.loginSuccessText;
}
