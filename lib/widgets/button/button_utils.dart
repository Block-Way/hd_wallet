part of widgets;

class ButtonUtils {
  static int lastClickTime = 0;

  static void doubleClick(Function func, [int interval = 350]) {
    final clickTime = DateTime.now().millisecondsSinceEpoch;
    if (lastClickTime == 0 || (lastClickTime - clickTime).abs() > interval) {
      lastClickTime = clickTime;
      func();
    }
  }
}
