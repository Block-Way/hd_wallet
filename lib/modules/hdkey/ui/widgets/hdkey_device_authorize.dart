part of hdkey_ui_module;

enum _AuthorizeSteps {
  intro,
  enterPin,
}

class HDKeyDeviceAuthorize extends HookWidget {
  HDKeyDeviceAuthorize({
    @required this.onAuthorize,
  });

  final pageController = PageController();

  final Future<bool> Function(String) onAuthorize;

  @override
  Widget build(BuildContext context) {
    final step = useState(_AuthorizeSteps.intro);
    final errorController = useStreamController<ErrorAnimationType>();
    final textController = useStreamController<String>();

    void doCheckPinCode(String pinCode) {
      onAuthorize(pinCode).then((value) {
        if (value != true) {
          errorController.add(ErrorAnimationType.shake);
          textController.add('密码不对');
        } else {
          Toast.show('连接成功');
          AppNavigator.goBack();
        }
      }).catchError((e) {
        Toast.showError(e);
      });
    }

    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Column(
          children: [
            CSImage(
              'assets/images/hdkey_tip_connected.png',
              width: 154,
              height: 109,
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: context.edgeVertical,
              child: Text(
                tr('硬件设备连接成功'),
                style: context.textBody(
                  color: context.titleColor,
                  bold: true,
                ),
              ),
            ),
            CSButton(
              label: tr('验证PIN码'),
              onPressed: () {
                step.value = _AuthorizeSteps.enterPin;
                pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              },
            ),
          ],
        ),
        Container(
          color: Colors.transparent,
          child: CSPinCodeInput(
            labelText: tr('确认硬件钱包PIN码'),
            btnText: tr('提交'),
            onPressed: (pinCode) {
              doCheckPinCode(pinCode);
            },
            errorController: errorController,
            textController: textController,
          ), // Enter PIN
        ),
      ],
    );
  }
}
