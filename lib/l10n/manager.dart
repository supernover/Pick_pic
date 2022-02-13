// use for no context,wait null safe
// // #docregion DemoLocalizations
// import 'dart:async';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // import 'l10n/messages_all.dart';
// class MyLocalizations {
//   MyLocalizations(this.localeName);
//
//   // static Future<MyLocalizations> load(Locale locale) {
//   //   final String name = locale.countryCode == null || locale.countryCode!.isEmpty
//   //       ? locale.languageCode
//   //       : locale.toString();
//   //   final String localeName = Intl.canonicalizedLocale(name);
//   //
//   //   return initializeMessages(localeName).then((_) {
//   //     return MyLocalizations(localeName);
//   //   });
//   // }
//
//   static MyLocalizations of(BuildContext context) {
//     return Localizations.of<MyLocalizations>(context, MyLocalizations)!;
//   }
//
//   final String localeName;
//
//   String get title {
//     return Intl.message(
//       'Hello World',
//       name: 'title',
//       desc: 'Title for the Demo application',
//       locale: localeName,
//     );
//   }
// }
//
// class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
//   const MyLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);
//
//   @override
//   Future<MyLocalizations> load(Locale locale) => MyLocalizations.load(locale);
//
//   @override
//   bool shouldReload(MyLocalizationsDelegate old) => false;
// }
//
