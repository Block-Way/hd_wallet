part of wallet_ui_module;

class _ErrorTip {
  _ErrorTip(
    this.tip,
    this.lv,
  );
  final String tip;
  final int lv;
}

class PasswordCheckTip extends StatefulWidget {
  const PasswordCheckTip({Key key}) : super(key: key);

  @override
  PasswordCheckTipState createState() => PasswordCheckTipState();
}

class PasswordCheckTipState extends State<PasswordCheckTip> {
  int errorLevel = 7;
  bool needShowTip = true;

  final tips = [
    _ErrorTip(tr('wallet:check_pwd_rule1'), 1),
    _ErrorTip(tr('wallet:check_pwd_rule2'), 2),
    _ErrorTip(tr('wallet:check_pwd_rule3'), 4),
  ];

  void showPasswordTip() {
    if (needShowTip) {
      needShowTip = false;
      final dialogContent = tr('wallet:check_pwd_tip1');
      Timer.run(() {
        showAlertDialog(context, content: dialogContent);
      });
    }
  }

  String getPasswordErrors() {
    for (var i = 0; i < tips.length; i++) {
      if (errorLevel & tips[i].lv != 0) {
        return tips[i].tip;
      }
    }
    return '';
  }

  void checkPassword(String password, String passwordConfirm) {
    // 第一次点击输入框的时候 需要给提示
    var newErrorLevel = 0;
    if (!RegExp(WalletPasswordValidator.walletPasswordRegex)
        .hasMatch(password)) {
      newErrorLevel = newErrorLevel | 1;
    } else if (newErrorLevel & 1 != 0) {
      newErrorLevel = 1 ^ newErrorLevel;
    }

    if (password.length < 8) {
      newErrorLevel = newErrorLevel | 2;
    } else if (newErrorLevel & 2 != 0) {
      newErrorLevel = 2 ^ newErrorLevel;
    }

    if (password.isEmpty || password != passwordConfirm) {
      newErrorLevel = newErrorLevel | 4;
    } else if (newErrorLevel & 4 != 0) {
      newErrorLevel = 4 ^ newErrorLevel;
    }

    setState(() {
      errorLevel = newErrorLevel;
    });
  }

  Widget buildTipView(_ErrorTip item) {
    final isInvalid = (item.lv & errorLevel) != 0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.edgeSize,
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(
            isInvalid ? Icons.panorama_fish_eye : Icons.check_circle_outline,
            size: 15,
            color: isInvalid ? context.redColor : context.greenColor,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              item.tip,
              style: context.textSecondary(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.edgeVertical5,
      child: Wrap(
        children: tips.map((e) => buildTipView(e)).toList(),
      ),
    );
  }
}
