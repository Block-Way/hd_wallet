part of widgets;

Timer timer;

class CSButtonTimeout extends HookWidget {
  const CSButtonTimeout({
    Key key,
    this.onPressed,
    this.countdown,
    this.btnText,
    this.btnColor,
  }) : super(key: key);

  final Function onPressed;
  final int countdown;
  final String btnText;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    final isCounting = useState(false);
    final countTime = useState(countdown);

    void handleConfirm() {
      if (isCounting.value == true) {
        return;
      }
      if (countTime.value != 0) {
        isCounting.value = true;
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          countTime.value = countTime.value - 1;
          if (countTime.value == 0) {
            isCounting.value = false;
            timer.cancel();
          }
        });
      } else {
        onPressed();
      }
    }

    return CSButton(
      onPressed: handleConfirm,
      label: isCounting.value
          ? tr(
              'global:btn_timeout',
              namedArgs: {'time': '${countTime.value}'},
            )
          : btnText,
    );

    // return FlatButton(
    //   onPressed: handleConfirm,
    //   child: Text(
    //     ,
    //     style: context.textBody(
    //       bold: !isCounting.value,
    //       color: isCounting.value
    //           ? context.bodyColor
    //           : btnColor ?? context.redColor,
    //     ),
    //   ),
    // );
  }
}
