import 'dart:ui' as ui show Image;
import 'dart:ui';

/// puzzle item
class PuzzleNode {
  late int curIndex;
  late int index;
  late Path path;
  late Rect rect;
  ui.Image? image;

  int getXIndex(int level) {
    return index % level;
  }

  int getYIndex(int level) {
    return (index / level).floor();
  }
}
