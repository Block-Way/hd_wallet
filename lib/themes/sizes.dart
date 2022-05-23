part of themes;

enum FontSizes { extraTiny, tiny, small, normal, secondary, medium, big, huge }

const double _edgeSize = 12;

extension StylesSizes on BuildContext {
  double get mediaWidth => MediaQuery.of(this).size.width;
  double get mediaHeight => MediaQuery.of(this).size.height;
  double get safeAreaTop => MediaQuery.of(this).viewPadding.top;
  double get safeAreaBottom => MediaQuery.of(this).viewPadding.bottom;
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;
  bool get keyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// 12px
  double get edgeSize => _edgeSize;
  double get edgeSizeHalf => _edgeSize / 2;
  double get edgeSizeDouble => _edgeSize * 2;

  EdgeInsets get edgeAll => const EdgeInsets.all(_edgeSize);
  EdgeInsets get edgeLeft => const EdgeInsets.only(left: _edgeSize);
  EdgeInsets get edgeRight => const EdgeInsets.only(right: _edgeSize);
  EdgeInsets get edgeTop => const EdgeInsets.only(top: _edgeSize);
  EdgeInsets get edgeBottom => const EdgeInsets.only(bottom: _edgeSize);
  EdgeInsets get edgeVertical =>
      const EdgeInsets.symmetric(vertical: _edgeSize);
  EdgeInsets get edgeHorizontal =>
      const EdgeInsets.symmetric(horizontal: _edgeSize);

  EdgeInsets get edgeAll5 => const EdgeInsets.all(5);
  EdgeInsets get edgeLeft5 => const EdgeInsets.only(left: 5);
  EdgeInsets get edgeRight5 => const EdgeInsets.only(right: 5);
  EdgeInsets get edgeTop5 => const EdgeInsets.only(top: 5);
  EdgeInsets get edgeBottom5 => const EdgeInsets.only(bottom: 5);
  EdgeInsets get edgeVertical5 => const EdgeInsets.symmetric(vertical: 5);
  EdgeInsets get edgeHorizontal5 => const EdgeInsets.symmetric(horizontal: 5);

  EdgeInsets get edgeAll8 => const EdgeInsets.all(8);
  EdgeInsets get edgeLeft8 => const EdgeInsets.only(left: 8);
  EdgeInsets get edgeRight8 => const EdgeInsets.only(right: 8);
  EdgeInsets get edgeTop8 => const EdgeInsets.only(top: 8);
  EdgeInsets get edgeBottom8 => const EdgeInsets.only(bottom: 8);
  EdgeInsets get edgeVertical8 => const EdgeInsets.symmetric(vertical: 8);
  EdgeInsets get edgeHorizontal8 => const EdgeInsets.symmetric(horizontal: 8);

  EdgeInsets get edgeAll10 => const EdgeInsets.all(10);
  EdgeInsets get edgeLeft10 => const EdgeInsets.only(left: 10);
  EdgeInsets get edgeRight10 => const EdgeInsets.only(right: 10);
  EdgeInsets get edgeBottom10 => const EdgeInsets.only(bottom: 10);
  EdgeInsets get edgeTop10 => const EdgeInsets.only(top: 10);
  EdgeInsets get edgeVertical10 => const EdgeInsets.symmetric(vertical: 10);
  EdgeInsets get edgeHorizontal10 => const EdgeInsets.symmetric(horizontal: 10);

  EdgeInsets get edgeAll16 => const EdgeInsets.all(16);
  EdgeInsets get edgeLeft16 => const EdgeInsets.only(left: 16);
  EdgeInsets get edgeRight16 => const EdgeInsets.only(right: 16);
  EdgeInsets get edgeTop16 => const EdgeInsets.only(top: 16);
  EdgeInsets get edgeBottom16 => const EdgeInsets.only(bottom: 16);
  EdgeInsets get edgeVertical16 => const EdgeInsets.symmetric(vertical: 16);
  EdgeInsets get edgeHorizontal16 => const EdgeInsets.symmetric(horizontal: 16);

  EdgeInsets get edgeAll20 => const EdgeInsets.all(20);
  EdgeInsets get edgeLeft20 => const EdgeInsets.only(left: 20);
  EdgeInsets get edgeRight20 => const EdgeInsets.only(right: 20);
  EdgeInsets get edgeTop20 => const EdgeInsets.only(top: 20);
  EdgeInsets get edgeBottom20 => const EdgeInsets.only(bottom: 20);
  EdgeInsets get edgeVertical20 => const EdgeInsets.symmetric(vertical: 20);
  EdgeInsets get edgeHorizontal20 => const EdgeInsets.symmetric(horizontal: 20);

  BorderRadius get radiusTop => BorderRadius.vertical(
        top: Radius.circular(_edgeSize),
      );

  BorderRadius get radiusAll => BorderRadius.circular(_edgeSize);
  BorderRadius get radiusAll5 => BorderRadius.circular(5);
  BorderRadius get radiusAll8 => BorderRadius.circular(8);
  BorderRadius get radiusAll10 => BorderRadius.circular(10);
  BorderRadius get radiusAll16 => BorderRadius.circular(16);
  BorderRadius get radiusAll20 => BorderRadius.circular(20);
}
