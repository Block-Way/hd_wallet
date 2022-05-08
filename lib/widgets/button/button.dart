part of widgets;

class CSButton extends StatelessWidget {
  const CSButton({
    Key key,
    this.label,
    this.borderColor,
    this.borderRadius,
    this.onPressed,
    this.textColor,
    this.textStyle,
    this.textBold = true,
    this.backgroundColor,
    this.fullwidth = false,
    this.autoWidth = false,
    this.flat = false,
    this.mini = false,
    this.loading = false,
    this.disabled = false,
    this.bordered = false,
    this.disableDebounce = false,
    this.doubleClickInterval = 350,
    this.borderWidth,
    this.height,
    this.width,
    this.child,
    this.cmpLeft,
    this.cmpRight,
    this.margin,
    this.padding,
    this.customBorder,
    this.mainAxisSize = MainAxisSize.max,
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

  final String label;
  final Color borderColor;
  final double borderRadius;

  /// 按钮事件
  final void Function() onPressed;

  /// 按钮字体颜色
  final Color textColor;
  final TextStyle textStyle;
  final bool textBold;
  final Color backgroundColor;
  final bool mini;
  final bool fullwidth;
  final bool autoWidth;
  final bool flat;
  final bool bordered;
  final double borderWidth;
  final bool loading;
  final bool disabled;
  final double height;
  final double width;
  final Widget child;
  final Widget cmpLeft;
  final Widget cmpRight;
  final MainAxisAlignment alignment;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final MainAxisSize mainAxisSize;

  /// 关闭连续点击限制
  final bool disableDebounce;
  final int doubleClickInterval;
  final ShapeBorder customBorder;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽高
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // Calculate style
    final btnHeight = mini ? 50.00 : 50.00;
    final btnWidth = mini ? screenWidth * 0.3 : screenWidth * 0.6;
    final btnBorderRadius = context.edgeSize;
    final btnBgColor = disabled
        ? context.btnDisabledBgColor
        : backgroundColor ?? context.btnPrimaryBgColor;
    final btnTextColor =
        disabled ? context.btnDisabledTextColor : context.btnPrimaryTextColor;

    // Flat will overwrite default style
    final finalWidth = flat ? null : (fullwidth ? screenWidth : btnWidth);
    final finalHeight = flat ? null : btnHeight;
    final finalBgColor = flat ? Colors.transparent : btnBgColor;
    final finalTextColor = flat ? context.bodyColor : btnTextColor;
    final finalBorderRadius = flat ? 0.0 : btnBorderRadius;
    final finalBorderRadiusCircle = Radius.circular(
      borderRadius ?? finalBorderRadius,
    );

    void handlePress() {
      if (onPressed != null) {
        if (disableDebounce) {
          onPressed();
        } else {
          ButtonUtils.doubleClick(onPressed, doubleClickInterval);
        }
      }
    }

    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(finalBorderRadiusCircle),
        color: finalBgColor,
        border: bordered == true
            ? Border.all(
                color: borderColor ?? context.bodyColor,
                width: borderWidth ?? 1.0,
              )
            : null,
      ),
      width: autoWidth == true ? null : width ?? finalWidth,
      height: height ?? finalHeight,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder: customBorder,
          splashColor: context.bgSecondaryColor,
          borderRadius: BorderRadius.all(finalBorderRadiusCircle),
          onTap: onPressed == null ? null : handlePress,
          child: Container(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: flat ? 0 : context.edgeSize,
                ),
            child: Row(
              mainAxisAlignment: alignment,
              mainAxisSize: mainAxisSize,
              children: [
                if (cmpLeft != null) cmpLeft,
                child ??
                    Center(
                      child: Text(
                        label ?? '',
                        style: textStyle ??
                            context.textButton(
                              bold: textBold,
                              color: textColor ?? finalTextColor,
                            ),
                      ),
                    ),
                if (cmpRight != null && !loading) cmpRight,
                if (loading)
                  Padding(
                    padding: context.edgeLeft5,
                    child: CSProgressIndicator(
                      size: 10,
                      color: context.whiteColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
