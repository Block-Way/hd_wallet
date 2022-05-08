part of widgets;

// enum Platform { iOS, other } //other indicates for web and android

class PinTheme {
  factory PinTheme(
      {Color activeColor,
      Color selectedColor,
      Color inactiveColor,
      Color disabledColor,
      Color activeFillColor,
      Color selectedFillColor,
      Color inactiveFillColor,
      BorderRadius borderRadius,
      double fieldHeight,
      double fieldWidth,
      double borderWidth,
      PinCodeFieldShape shape}) {
    final defaultValues = PinTheme.defaults();
    return PinTheme.defaults(
      activeColor: activeColor ?? defaultValues.activeColor,
      activeFillColor: activeFillColor ?? defaultValues.activeFillColor,
      borderRadius: borderRadius ?? defaultValues.borderRadius,
      borderWidth: borderWidth ?? defaultValues.borderWidth,
      disabledColor: disabledColor ?? defaultValues.disabledColor,
      fieldHeight: fieldHeight ?? defaultValues.fieldHeight,
      fieldWidth: fieldWidth ?? defaultValues.fieldWidth,
      inactiveColor: inactiveColor ?? defaultValues.inactiveColor,
      inactiveFillColor: inactiveFillColor ?? defaultValues.inactiveFillColor,
      selectedColor: selectedColor ?? defaultValues.selectedColor,
      selectedFillColor: selectedFillColor ?? defaultValues.selectedFillColor,
      shape: shape ?? defaultValues.shape,
    );
  }

  const PinTheme.defaults({
    this.borderRadius = BorderRadius.zero,
    this.fieldHeight = 50,
    this.fieldWidth = 40,
    this.borderWidth = 1,
    this.shape = PinCodeFieldShape.box,
    this.activeColor = const Color(0xFFeeeeee),
    this.selectedColor = const Color(0xFFeeeeee),
    this.inactiveColor = const Color(0xFFeeeeee),
    this.disabledColor = const Color(0xFFeeeeee),
    this.activeFillColor = const Color(0xFFeeeeee),
    this.selectedFillColor = const Color(0xFFeeeeee),
    this.inactiveFillColor = const Color(0xFFeeeeee),
  });

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeColor;

  /// Color of the input field which is currently selected.
  ///  Default is [Colors.blue]
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs.
  /// Default is [Colors.red]
  final Color inactiveColor;

  /// Colors of the input fields if the [PinCodeTextField] is disabled.
  /// Default is [Colors.grey]
  final Color disabledColor;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeFillColor;

  /// Color of the input field which is currently selected.
  ///  Default is [Colors.blue]
  final Color selectedFillColor;

  /// Colors of the input fields which don't have inputs.
  /// Default is [Colors.red]
  final Color inactiveFillColor;

  /// Border radius of each pin code field
  final BorderRadius borderRadius;

  /// [height] for the pin code field. default is [50.0]
  final double fieldHeight;

  /// [width] for the pin code field. default is [40.0]
  final double fieldWidth;

  /// Border width for the each input fields. Default is [2.0]
  final double borderWidth;

  /// this defines the shape of the input fields. Default is underlined
  final PinCodeFieldShape shape;
}
