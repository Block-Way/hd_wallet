part of hdkey_ui_module;

enum _CreateSteps {
  intro,
  enterPin,
  confirmPin,
  completed,
}

class HDKeyDeviceEmpty extends HookWidget {
  HDKeyDeviceEmpty({
    @required this.onCreate,
  });

  final pageController = PageController();

  final Future<bool> Function(String) onCreate;

  @override
  Widget build(BuildContext context) {
    final step = useState(_CreateSteps.intro);
    final pinCode = useState('');
    final btnWidth = (context.mediaWidth - 50) / 2;
    final errorMessage = useState('');
    final textController = useStreamController<String>();
    final errorController = useStreamController<ErrorAnimationType>();

    void goNextPage([int duration]) {
      pageController.nextPage(
        duration: Duration(milliseconds: duration ?? 200),
        curve: Curves.easeIn,
      );
    }

    void goPreviousPage([int duration]) {
      pageController.previousPage(
        duration: Duration(milliseconds: duration ?? 200),
        curve: Curves.easeIn,
      );
    }

    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        // page1
        Column(
          children: [
            CSImage(
              'assets/images/hdkey_tip_connected.png',
              width: context.mediaWidth * 0.39,
              height: context.mediaWidth * 0.27,
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                tr('您的设备尚未创建硬件钱包'),
                style: context.textBody(
                  bold: true,
                ),
              ),
            ),
            Padding(
              padding: context.edgeTop,
              child: Text(
                tr('请为硬件设置PIN码并创建钱包'),
                style: context.textBody(
                  color: context.labelColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CSButton(
                  label: tr('暂不创建'),
                  backgroundColor: context.bgSecondaryColor,
                  textColor: context.secondaryColor,
                  onPressed: () {
                    AppNavigator.goBack();
                  },
                  width: btnWidth,
                ),
                CSButton(
                  label: tr('下一步'),
                  width: btnWidth,
                  onPressed: () {
                    step.value = _CreateSteps.enterPin;
                    goNextPage();
                  },
                ),
              ],
            ),
          ],
        ),
        // page2
        CSPinCodeInput(
          labelText: '设置硬件钱包PIN码',
          errorText: errorMessage.value,
          confirmPin: pinCode.value,
          errorController: errorController,
          btnText: '下一步',
          textController: textController,
          isError: errorMessage.value.isNotEmpty,
          onPressed: (pin) {
            pinCode.value = pin;
            step.value = _CreateSteps.confirmPin;
            goNextPage();
            textController.add('');
          },
        ),
        // page3
        CSPinCodeInput(
          labelText: '确认硬件钱包PIN码',
          confirmPin: pinCode.value,
          btnText: '确认',
          textController: textController,
          errorController: errorController,
          onConfirm: () {
            errorMessage.value = tr('两次输入不一致，请重新输入');
            step.value = _CreateSteps.enterPin;
            goPreviousPage();
          },
          onPressed: (pin) {
            LoadingDialog.show(context);
            onCreate(pin).then((value) {
              LoadingDialog.dismiss(context);
              goNextPage(50);
              step.value = _CreateSteps.completed;
            }).catchError((e) {
              LoadingDialog.dismiss(context);
              Toast.showError(e);
            });
          },
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '硬件钱包创建成功',
                style: context.textBody(
                  color: context.titleColor,
                  bold: true,
                ),
              ),
              SizedBox(height: context.edgeSizeDouble),
              CSImage(
                'assets/images/have_deposit.png',
                width: context.mediaWidth * 0.3,
                height: context.mediaWidth * 0.3,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: context.edgeSize),
              CSButton(
                label: '确认',
                onPressed: () {
                  AppNavigator.goBack();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
