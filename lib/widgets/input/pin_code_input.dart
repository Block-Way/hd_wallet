part of widgets;

class CSPinCodeInput extends HookWidget {
  const CSPinCodeInput({
    @required this.textController,
    @required this.errorController,
    Key key,
    this.isHaveHDKey = false,
    this.confirmPin,
    this.onConfirm,
    this.btnText,
    this.labelText,
    this.onPressed,
    this.errorText = '',
    this.isError = false,
  }) : super(key: key);

  final bool isHaveHDKey;
  final String btnText;
  final String labelText;
  final String confirmPin;
  final Function(String pin) onPressed;
  final StreamController<ErrorAnimationType> errorController;
  final String errorText;
  final bool isError;
  final Function onConfirm;
  final StreamController<String> textController;

  @override
  Widget build(BuildContext context) {
    final width =
        NumberUtil.minus<double>(context.mediaWidth, context.edgeSizeDouble) /
            6;
    final pinCode = useTextEditingController(text: '');
    final isErrorMessage = useState(true);

    void handleSubmit() {
      if (pinCode.text.length != 6) {
        textController.add('密码必须为六位数');
        errorController.add(ErrorAnimationType.shake);
        return;
      }
      if (isErrorMessage.value) {
        errorController.add(ErrorAnimationType.shake);
        return;
      }
      onPressed(pinCode.text);
      isErrorMessage.value = false;
    }

    void onCompleted() {
      if (confirmPin.isNotEmpty && pinCode.text != confirmPin) {
        onConfirm();
        textController.add(tr('两次输入不一致，请重新输入'));
        errorController.add(ErrorAnimationType.shake);
        isErrorMessage.value = true;
      }
    }

    void checkPinCodeInput(String value) {
      if (errorText != null && errorText.isNotEmpty && isErrorMessage.value) {
        textController.add(errorText);
      } else {
        textController.add('');
      }
      isErrorMessage.value = false;
      pinCode.text = value;
    }

    return SizedBox(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: context.edgeBottom20,
              child: Text(
                labelText,
                style: context.textBody(
                  bold: true,
                  color: context.labelColor,
                ),
              ),
            ),
            PinCodeTextField(
              length: 6,
              autoFocus: true,
              cursorWidth: 1,
              obscureText: true,
              appContext: context,
              keyboardType: TextInputType.number,
              animationType: AnimationType.scale,
              entryPincode: isError ? confirmPin : '',
              autoDisposeControllers: false,
              pinTheme: PinTheme(
                fieldHeight: width,
                fieldWidth: width,
              ),
              animationDuration: Duration(milliseconds: 300),
              errorAnimationController: errorController,
              autoDismissKeyboard: false,
              obscuringCharacter: '*',
              mainAxisAlignment: MainAxisAlignment.start,
              onCompleted: (v) {
                onCompleted();
              },
              onChanged: (value) {
                checkPinCodeInput(value);
              },
            ),
            StreamBuilder(
              initialData: errorText,
              stream: textController.stream,
              builder: (context, snapshot) =>
                  snapshot.data.toString().isNotEmpty
                      ? Text(
                          tr(snapshot.data.toString()),
                          style: context.textSecondary(
                            color: context.redColor,
                          ),
                        )
                      : Container(),
            ),
            Center(
              child: CSButton(
                label: btnText,
                onPressed: () {
                  handleSubmit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
