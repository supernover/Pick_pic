import 'puzzle_node.dart';

/// make a list can use for puzzle
class PuzzleEngine {
  //when Reverse pair count isEven, can use for puzzle
  static void makeRandom(List<PuzzleNode> list) {
    List<int> arr = [];
    do {
      arr.clear();
      list.shuffle();
      for (int i = 0; i < list.length; i++) {
        list[i].curIndex = i;
        arr.add(list[i].index);
      }
    } while (!readyReversePairs(arr).isEven);
  }

  ///
  static int readyReversePairs(List<int> array) {
    if (array.length < 2) {
      return 0;
    }

    int len = array.length;
    List<int> temp = List<int>.filled(len, 0);

    return reversePairs(array, temp, 0, len - 1);
  }

  /// array
  /// temp
  /// start
  /// end
  static int reversePairs(List<int> array, List<int> temp, int start, int end) {
    int result = 0;
    if (start < end) {
      int mid = (start + (end - start) / 2).floor();

      /// start
      result += reversePairs(array, temp, start, mid);

      /// end
      result += reversePairs(array, temp, mid + 1, end);

      /// cross
      result += merge(array, temp, start, mid, end);
    }
    return result;
  }

  static int merge(
      List<int> array, List<int> temp, int start, int mid, int end) {
    int count = 0;
    for (int i = start; i <= end; i++) {
      temp[i] = array[i];
    }
    int i = start;
    int j = mid + 1;
    for (int k = start; k <= end; k++) {
      if (i == mid + 1) {
        array[k] = temp[j];
        j++;
      } else if (j == end + 1) {
        array[k] = temp[i];
        i++;
      } else if (temp[i] <= temp[j]) {
        array[k] = temp[i];
        i++;
      } else {
        array[k] = temp[j];
        j++;
        count += (mid - i + 1);
      }
    }
    return count;
  }
}
