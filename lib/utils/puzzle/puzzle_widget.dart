import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_pic/utils/puzzle/puzzle_util.dart';

import 'puzzle_config.dart';
import 'puzzle_engine.dart';
import 'puzzle_painter.dart';
import 'puzzle_node.dart';

/// use for control show or hide num in puzzle node
final numberVisibleProvider = StateProvider((ref) => true);

/// puzzle widget
class PuzzleWidget extends StatefulWidget {
  // screen size
  final Size size;

  // image data
  final Uint8List bytes;

  // puzzle leve,default 3 * 3
  final int level;

  // control timer
  final Function stopTimer;

  PuzzleWidget(
      {required this.size,
      required this.bytes,
      required this.level,
      required this.stopTimer});

  @override
  State<StatefulWidget> createState() {
    return PuzzleWidgetState(size, bytes, level);
  }
}

class PuzzleWidgetState extends State<PuzzleWidget>
    with TickerProviderStateMixin {
  final Size size;
  PuzzleUtil? puzzleUtil;
  late List<PuzzleNode> nodes;

  /// control animation when node move
  Animation<int>? alpha;
  AnimationController? controller;
  Map<int, PuzzleNode>? nodeMap = {};

  final int level;
  final Uint8List bytes;
  PuzzleNode? hitNode;

  double downX = 0.0, downY = 0.0, newX = 0.0, newY = 0.0;
  late int emptyIndex;
  Direction? direction;
  bool? needDraw = true, showNum = true;
  List<PuzzleNode?>? hitNodeList = [];

  GameState gameState = GameState.loading;

  PuzzleWidgetState(this.size, this.bytes, this.level) {
    puzzleUtil = PuzzleUtil();
    emptyIndex = level * level - 1;

    puzzleUtil!.init(bytes, size, level).then((val) {
      setState(() {
        nodes = puzzleUtil!.doTask();
        PuzzleEngine.makeRandom(nodes);
        setState(() {
          gameState = GameState.play;
        });
        showStartAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gameState == GameState.loading) {
      return Center(
        child: Text('Loading'),
      );
    } else if (gameState == GameState.complete) {
      widget.stopTimer();
      return Center(
          child: Column(
        children: [
          Container(
            child: Image.memory(bytes),
          ),
        ],
      ));
    } else {
      return GestureDetector(
        onPanDown: onPanDown,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Container(
          child: Consumer(
            builder: (context, watch, _) {
              return CustomPaint(
                  painter: PuzzlePainter(
                      nodes,
                      level,
                      hitNode,
                      hitNodeList!,
                      direction,
                      downX,
                      downY,
                      newX,
                      newY,
                      needDraw!,
                      watch(numberVisibleProvider).state),
                  size: Size.infinite);
            },
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  /// when game start
  /// random sort node index over
  /// move node to its position in widget(level * level)
  void showStartAnimation() {
    needDraw = true;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    alpha = IntTween(begin: 0, end: 100).animate(controller!);
    nodes.forEach((node) {
      nodeMap![node.curIndex] = node;

      Rect rect = node.rect;
      Rect dstRect = puzzleUtil!
          .getOkRectF(node.curIndex % level, (node.curIndex / level).floor());

      final dealtX = dstRect.left - rect.left;
      final dealtY = dstRect.top - rect.top;

      final oldX = rect.left;
      final oldY = rect.top;

      alpha!.addListener(() {
        double oldNewX2 = alpha!.value * dealtX / 100;
        double oldNewY2 = alpha!.value * dealtY / 100;
        setState(() {
          node.rect = Rect.fromLTWH(
              oldX + oldNewX2, oldY + oldNewY2, rect.width, rect.height);
        });
      });
    });
    alpha!.addStatusListener((AnimationStatus val) {
      if (val == AnimationStatus.completed) {
        needDraw = false;
      }
    });
    controller!.forward();
  }

  /// touch screen  ready to move
  void onPanDown(DragDownDetails details) {
    if (controller!.isAnimating) {
      return;
    }
    needDraw = true;
    RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    for (PuzzleNode node in nodes) {
      if (node.rect.contains(localPosition)) {
        hitNode = node;
        direction = isBetween(hitNode, emptyIndex);
        if (direction != Direction.none) {
          newX = downX = localPosition.dx;
          newY = downY = localPosition.dy;

          nodes.remove(hitNode);
          nodes.add(hitNode!);
        }
        setState(() {});
        break;
      }
    }
  }

  /// move
  void onPanUpdate(DragUpdateDetails details) {
    if (hitNode == null) {
      return;
    }
    RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    newX = localPosition.dx;
    newY = localPosition.dy;
    if (direction == Direction.top) {
      newY = min(downY, max(newY, downY - hitNode!.rect.width));
    } else if (direction == Direction.bottom) {
      newY = max(downY, min(newY, downY + hitNode!.rect.width));
    } else if (direction == Direction.left) {
      newX = min(downX, max(newX, downX - hitNode!.rect.width));
    } else if (direction == Direction.right) {
      newX = max(downX, min(newX, downX + hitNode!.rect.width));
    }

    setState(() {});
  }

  /// stopped contacting the screen.
  /// move finish
  /// get current puzzle state
  void onPanEnd(DragEndDetails details) {
    if (hitNode == null) {
      return;
    }
    needDraw = false;
    if (direction == Direction.top) {
      if (-(newY - downY) > hitNode!.rect.width / 2) {
        swapEmpty();
      }
    } else if (direction == Direction.bottom) {
      if (newY - downY > hitNode!.rect.width / 2) {
        swapEmpty();
      }
    } else if (direction == Direction.left) {
      if (-(newX - downX) > hitNode!.rect.width / 2) {
        swapEmpty();
      }
    } else if (direction == Direction.right) {
      if (newX - downX > hitNode!.rect.width / 2) {
        swapEmpty();
      }
    }

    hitNodeList!.clear();
    hitNode = null;

    /// over over
    bool isComplete = true;
    nodes.forEach((node) {
      if (node.curIndex != node.index) {
        isComplete = false;
      }
    });
    if (isComplete) {
      gameState = GameState.complete;
    }

    setState(() {});
  }

  Direction isBetween(PuzzleNode? node, int emptyIndex) {
    int x = emptyIndex % level;
    int y = (emptyIndex / level).floor();

    int x2 = node!.curIndex % level;
    int y2 = (node.curIndex / level).floor();

    if (x == x2) {
      if (y2 < y) {
        for (int index = y2; index < y; ++index) {
          hitNodeList!.add(nodeMap![index * level + x]);
        }
        return Direction.bottom;
      } else if (y2 > y) {
        for (int index = y2; index > y; --index) {
          hitNodeList!.add(nodeMap![index * level + x]);
        }
        return Direction.top;
      }
    }
    if (y == y2) {
      if (x2 < x) {
        for (int index = x2; index < x; ++index) {
          hitNodeList!.add(nodeMap![y * level + index]);
        }
        return Direction.right;
      } else if (x2 > x) {
        for (int index = x2; index > x; --index) {
          hitNodeList!.add(nodeMap![y * level + index]);
        }
        return Direction.left;
      }
    }
    return Direction.none;
  }

  void swapEmpty() {
    int v = -level;
    if (direction == Direction.right) {
      v = 1;
    } else if (direction == Direction.left) {
      v = -1;
    } else if (direction == Direction.bottom) {
      v = level;
    }
    hitNodeList!.forEach((node) {
      node!.curIndex += v;
      nodeMap![node.curIndex] = node;
      node.rect = puzzleUtil!
          .getOkRectF(node.curIndex % level, (node.curIndex / level).floor());
    });
    emptyIndex -= v * hitNodeList!.length;
  }
}
