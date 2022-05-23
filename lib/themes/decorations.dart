part of themes;

extension DecorationStyles on BuildContext {
  /// - Radius 12px
  /// - Color  #FFFFFF
  BoxDecoration boxDecoration({Color color, double radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? edgeSize),
      ),
      color: color ?? bgPrimaryColor,
    );
  }

  BoxDecoration boxDecorationOnlyTop({Color color, double radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(radius ?? edgeSize),
      ),
      color: color ?? bgPrimaryColor,
    );
  }

  BoxDecoration boxDecorationOnlyBottom({Color color, double radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(radius ?? edgeSize),
      ),
      color: color ?? bgPrimaryColor,
    );
  }

  BoxDecoration boxDecorationOnlyLeft({Color color, double radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(radius ?? edgeSize),
      ),
      color: color ?? bgPrimaryColor,
    );
  }

  BoxDecoration boxDecorationWithBorder({
    Color color,
    double radius,
    Color borderColor,
    double borderWidth,
    bool radiusTopLeft = true,
    bool radiusTopRight = true,
    bool radiusBottomLeft = true,
    bool radiusBottomRight = true,
  }) {
    final radiusStyle = Radius.circular(radius ?? edgeSize);
    return BoxDecoration(
      border: Border.all(
        color: borderColor ?? borderColor,
        width: borderWidth ?? 1,
      ),
      borderRadius: BorderRadius.only(
        topLeft: radiusTopLeft == true ? radiusStyle : Radius.zero,
        topRight: radiusTopRight == true ? radiusStyle : Radius.zero,
        bottomLeft: radiusBottomLeft == true ? radiusStyle : Radius.zero,
        bottomRight: radiusBottomRight == true ? radiusStyle : Radius.zero,
      ),
      color: color ?? bgPrimaryColor,
    );
  }

  BoxDecoration boxCardShadow({Color color, double radius}) {
    return BoxDecoration(
      color: color ?? bgPrimaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? edgeSize),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(226, 226, 226, 0.5),
          blurRadius: 16,
          spreadRadius: 1,
          offset: Offset(0, 6),
        ),
      ],
    );
  }

  BoxDecoration boxCardBorder({
    Color color,
    Color borderColor,
    double borderWidth,
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    final borderStyle = BorderSide(
      color: borderColor ?? borderColor,
      width: borderWidth ?? 1,
    );
    return BoxDecoration(
      color: color ?? bgPrimaryColor,
      border: Border(
        top: top == true ? borderStyle : BorderSide.none,
        bottom: bottom == true ? borderStyle : BorderSide.none,
        left: left == true ? borderStyle : BorderSide.none,
        right: right == true ? borderStyle : BorderSide.none,
      ),
    );
  }
}
