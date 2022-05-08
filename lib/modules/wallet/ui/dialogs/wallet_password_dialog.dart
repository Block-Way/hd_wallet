part of wallet_ui_module;

void showPasswordDialog(
  BuildContext context,
  Future<WalletPrivateData> Function(String password) onUnlockRequest,
  void Function(WalletPrivateData data, String password) onUnlockSuccess, {
  String defaultValue,
}) {
  showCSBottomSheet(
    context,
    (context) => WalletPasswordDialog(
      onUnlockRequest: onUnlockRequest,
      onUnlockSuccess: onUnlockSuccess,
      defaultValue: defaultValue,
    ),
    minHeight: 0,
    maxHeight: context.mediaHeight * 0.35,
  );
}

class WalletPasswordDialog extends HookWidget {
  const WalletPasswordDialog({
    @required this.onUnlockRequest,
    @required this.onUnlockSuccess,
    this.defaultValue = '',
  });

  final String defaultValue;

  /// Request unlock wallet
  final Future<WalletPrivateData> Function(String password) onUnlockRequest;

  /// Success unlock wallet
  final void Function(WalletPrivateData data, String password) onUnlockSuccess;

  static const countdownLimit = 60;

  @override
  Widget build(BuildContext context) {
    final fieldPassword = useTextEditingController(
      text: kDebugMode ? 'Qq111111' : defaultValue,
    );
    final countdownSub = useValueNotifier<StreamSubscription>();
    final countdownInc = useStreamController<int>();
    final buttonDisabled = useStreamController<bool>();

    void handleCancel() {
      AppNavigator.goBack();
    }

    Future<void> startCountdown() async {
      countdownInc.add(countdownLimit);
      countdownSub.value?.cancel();
      countdownSub.value =
          Stream.periodic(Duration(seconds: 1), (x) => countdownLimit - x - 1)
              .take(countdownLimit)
              .listen(
        (inc) {
          countdownInc.add(inc);
        },
        onDone: () {
          handleCancel();
        },
      );
    }

    void handleSubmit(BuildContext context, String password) {
      if (password != null && password.isNotEmpty) {
        LoadingDialog.show(context);
        onUnlockRequest(password).then((data) {
          LoadingDialog.dismiss(context);
          AppNavigator.goBack();
          onUnlockSuccess(data, password);
        }).catchError((error) {
          LoadingDialog.dismiss(context);
          Toast.show(tr('wallet:tip_pwd_invalid'));
          startCountdown();
          throw error;
        });
      } else {
        Toast.show(tr('wallet:tip_pwd_empty'));
      }
    }

    useEffect(() {
      startCountdown();
      return () {
        countdownSub.value?.cancel();
      };
    }, []);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormBoxPassword(
          margin: context.edgeHorizontal,
          autoFocus: true,
          bordered: true,
          controller: fieldPassword,
          title: tr('wallet:lbl_verify_pwd'),
          titleStyle: context.textBody(
            bold: true,
          ),
          titleAction: StreamBuilder<int>(
            initialData: countdownLimit,
            stream: countdownInc.stream,
            builder: (context, snapshot) => Text(
              tr('wallet:lbl_verify_pwd_countdown', namedArgs: {
                'seconds': snapshot.data.toString(),
              }),
              style: context.textSecondary(),
            ),
          ),
          hintText: tr('wallet:hint_verify_pwd'),
          onChanged: (text) {
            buttonDisabled.add(text.isEmpty);
          },
        ),
        Spacer(),
        SizedBox(height: context.edgeSize),
        Container(
          margin: context.edgeHorizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CSButton(
                  label: tr('global:btn_cancel'),
                  onPressed: () {
                    handleCancel();
                  },
                  bordered: true,
                  backgroundColor: context.bgPrimaryColor,
                ),
              ),
              SizedBox(width: context.edgeSize),
              Flexible(
                child: StreamBuilder<bool>(
                  initialData: fieldPassword.text.isEmpty,
                  stream: buttonDisabled.stream,
                  builder: (context, snapshot) => CSButton(
                    label: tr('global:btn_commit'),
                    disabled: snapshot.data,
                    onPressed: () {
                      handleSubmit(context, fieldPassword.text);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.edgeSize),
      ],
    );
  }
}
