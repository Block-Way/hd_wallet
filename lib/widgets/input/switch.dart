part of widgets;

class CSSwitch extends HookWidget {
  const CSSwitch({
    @required this.value,
    Key key,
    this.onChanged,
    this.onChangedBack,
  }) : super(key: key);

  final bool Function(bool value) onChangedBack;
  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final isActive = useState(value);

    return Transform.scale(
      scale: 0.75,
      child: Transform.translate(
        offset: Offset(10, 0),
        child: CupertinoSwitch(
          value: isActive.value, // 设置值，true开，false关
          onChanged: (value) {
            if (onChangedBack != null) {
              if (onChangedBack(value)) {
                isActive.value = value;
              }
            } else {
              onChanged(value);
              isActive.value = value;
            }
          }, // 值变化时调用
          activeColor: context.primaryColor,
          trackColor: context.placeholderColor,
        ),
      ),
    );

    // return Switch(
    //   value: isActive.value, // 设置值，true开，false关
    //   onChanged: handleChanged, // 值变化时调用
    //   activeColor: ThemeColors.whiteColor(context), // 为true时的颜色 圆圈颜色
    //   activeTrackColor: ThemeColors.primaryColor(
    //       context), // 为true 时，bar的颜色 如果不设置此值，bar的颜色为activeColor颜色
    //   inactiveThumbColor: ThemeColors.whiteColor(context), // 为false时 圆圈的颜色
    //   //为false时，bar的颜色。如果不设置此值，默认灰色
    // );
  }
}
