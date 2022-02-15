import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/utils/puzzle/puzzle_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PuzzlePlayPage extends StatefulWidget {
  final Size size;
  final Uint8List bytes;
  final int level;

  PuzzlePlayPage(this.size, this.bytes, this.level);

  @override
  State<StatefulWidget> createState() => PuzzlePlayState();
}

class PuzzlePlayState extends State<PuzzlePlayPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    Future<dynamic>.delayed(Duration(seconds: 1)).then((dynamic value) =>
        _stopWatchTimer.onExecute.add(StopWatchExecute.start));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: _buildBody(size),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'float',
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                context.read(numberVisibleProvider).state ^= true;
                ;
              },
              child: SvgPicture.asset(
                'assets/icons/point.svg',
                width: smallSize,
                height: smallSize,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: smallSize,
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                width: smallSize,
                height: smallSize,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(Size size) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/images/bg_puzzle.jpg').image)),
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTimeBoard(size),
            _buildGameBoard(size),
          ],
        ),
      ),
    );
  }

  Widget _buildGameBoard(Size size) {
    return Container(
      height: size.width,
      child: PuzzleWidget(
        size: size,
        bytes: widget.bytes,
        level: widget.level,
        stopTimer: () {
          _stopWatchTimer.dispose();
        },
      ),
    );
  }

  Widget _buildTimeBoard(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.width / 3),
      // color: Colors.transparent,
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: 0,
        builder: (context, snap) {
          final value = snap.data;
          final displayTime =
              StopWatchTimer.getDisplayTime(value!, milliSecond: false);
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: TextStyle(
                        fontSize: bigMediumText,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _stopWatchTimer.execute;
    super.dispose();
  }
}
