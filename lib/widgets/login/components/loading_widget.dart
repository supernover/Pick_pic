import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// use for loading animation widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.loginTag, this.color}) : super(key: key);
  final int? loginTag;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Scaffold(
        body: Container(
          width: size.width / 4,
          height: size. height / 4,
          child: Hero(
              tag: '$loginTag',
              child: SvgPicture.asset('assets/icons/profile_user.svg')),
        ),
      ),
    );
  }
}
