import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

addScroll(Widget child, index, AutoScrollController autoScrollController) {
  return AutoScrollTag(
    key: ValueKey(index),
    controller: autoScrollController,
    index: index,
    child: child,
  );
}

scrollIndex(int index, AutoScrollController autoScrollController) {
  autoScrollController.scrollToIndex(index);
}
