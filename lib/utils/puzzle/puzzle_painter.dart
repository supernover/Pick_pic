import 'dart:ui';
import 'dart:ui' as ui show TextStyle;

import 'package:flutter/material.dart';

import 'puzzle_config.dart';
import 'puzzle_node.dart';

class PuzzlePainter extends CustomPainter {
  late Paint mPaint;
  late Path path;
  final int level;
  final List<PuzzleNode> nodes;
  final PuzzleNode? hitNode;
  final bool needDraw;
  final bool showNum;

  final double downX, downY, newX, newY;
  final List<PuzzleNode?> hitNodeList;
  final Direction? direction;

  PuzzlePainter(
      this.nodes,
      this.level,
      this.hitNode,
      this.hitNodeList,
      this.direction,
      this.downX,
      this.downY,
      this.newX,
      this.newY,
      this.needDraw,
      this.showNum) {
    mPaint = Paint();
    path = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (PuzzleNode node in nodes) {
      Rect rect2 = node.rect;
      if (hitNodeList.contains(node)) {
        if (direction == Direction.left || direction == Direction.right) {
          rect2 = node.rect.shift(Offset(newX - downX, 0.0));
        } else if (direction == Direction.top ||
            direction == Direction.bottom) {
          rect2 = node.rect.shift(Offset(0.0, newY - downY));
        }
      }
      if (node.image != null) {
        Rect srcRect = Rect.fromLTRB(0.0, 0.0, node.image!.width.toDouble(),
            node.image!.height.toDouble());
        canvas.drawImageRect(node.image!, srcRect, rect2, mPaint);
      }
    }
    // control index visibility
    if (showNum) {
      for (PuzzleNode node in nodes) {
        ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontSize: hitNode == node ? 20.0 : 15.0,
        ));
        if (hitNode == node) {
          pb.pushStyle(ui.TextStyle(color: Color(0xff00ff00)));
        }
        pb.addText('${node.index + 1}');
        ParagraphConstraints pc = ParagraphConstraints(width: node.rect.width);
        Paragraph paragraph = pb.build()..layout(pc);

        Offset offset = Offset(node.rect.left,
            node.rect.top + node.rect.height / 2 - paragraph.height / 2);
        if (hitNodeList.contains(node)) {
          if (direction == Direction.left || direction == Direction.right) {
            offset = Offset(offset.dx + newX - downX, offset.dy);
          } else if (direction == Direction.top ||
              direction == Direction.bottom) {
            offset = Offset(offset.dx, offset.dy + newY - downY);
          }
        }
        canvas.drawParagraph(paragraph, offset);
      }
    }
  }

  @override
  bool shouldRepaint(PuzzlePainter oldDelegate) {
    return needDraw || oldDelegate.needDraw;
  }
}
