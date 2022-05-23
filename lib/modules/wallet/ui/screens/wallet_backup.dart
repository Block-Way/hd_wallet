part of wallet_ui_module;

enum _BackupStep { intro, showMnemonic, validateMnemonic }

class WalletBackupPage extends HookWidget {
  const WalletBackupPage(this.mnemonicList);
  final List<String> mnemonicList;

  static const routeName = '/wallet/backup';

  static void open(String mnemonic) {
    AppNavigator.push(routeName, params: mnemonic);
  }

  static Route<dynamic> route(RouteSettings settings) {
    final mnemonic = settings.arguments as String;
    final mnemonicList = mnemonic.split(' ');
    return DefaultTransition(
      settings,
      WalletBackupPage(mnemonicList),
    );
  }

  Widget buildTipView(
    BuildContext context,
    ValueNotifier<_BackupStep> step,
    WalletBackupVM viewModel,
  ) {
    return Column(
      children: [
        SizedBox(height: 10),
        CSContainer(
          child: MnemonicBackupMsgTip(),
        ),
        SizedBox(height: 50),
        CSButton(
          label: tr('wallet:backup_btn_start'),
          onPressed: () {
            step.value = _BackupStep.showMnemonic;
          },
          margin: context.edgeVertical,
        ),
        SizedBox(height: context.edgeSize),
        CSButton(
          label: tr('wallet:backup_btn_later'),
          flat: true,
          onPressed: () {
            AppNavigator.gotoTabBar();
          },
          margin: EdgeInsets.only(bottom: 40),
        )
      ],
    );
  }

  Widget buildMnemonicView(
    BuildContext context,
    ValueNotifier<_BackupStep> step,
    WalletBackupVM viewModel,
  ) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: context.edgeAll,
          child: Column(
            children: [
              Text(
                tr('wallet:backup_lbl_1'),
                style: context.textBody(bold: true),
              ),
              SizedBox(height: 10),
              Text(
                tr('wallet:backup_lbl_2'),
                style: context.textBody(color: context.orangeColor),
              ),
            ],
          ),
        ),
        SizedBox(height: context.edgeSize),
        MnemonicCard(mnemonic: mnemonicList),
        SizedBox(height: context.edgeSize),
        SizedBox(height: 50),
        CSButton(
          label: tr('wallet:backup_btn_next'),
          onPressed: () {
            step.value = _BackupStep.validateMnemonic;
          },
        )
      ],
    );
  }

  bool checkMnemonicInvalid(List<String> list) {
    if (list.length != mnemonicList.length) {
      return true;
    }
    var state = false;
    list.asMap().forEach((index, value) {
      if (mnemonicList[index] != value.split('_')[0]) {
        state = true;
      }
    });
    return state;
  }

  // 验证 选择页面
  Widget buildConfirmView(
    BuildContext context,
    WalletBackupVM viewModel,
    ValueNotifier<List<String>> select,
    ValueNotifier<List<String>> randomList,
  ) {
    final isInvalid = checkMnemonicInvalid(select.value);
    final list = [...mnemonicList];
    list.asMap().forEach((index, value) {
      list[index] = '${value}_$index';
    });

    // 重置列表随机列表
    if (randomList.value.isEmpty) {
      for (var i = list.length - 1; i >= 0; i--) {
        final randomIndex = math.Random().nextInt(i == 0 ? 1 : i);
        final itemIndex = list[randomIndex];
        list[randomIndex] = list[i];
        list[i] = itemIndex;
      }
      randomList.value = list;
    }

    return Padding(
      padding: context.edgeAll,
      child: Column(
        children: [
          Text(
            tr('wallet:backup_lbl_3'),
            style: context.textBody(bold: true),
          ),
          SizedBox(height: context.edgeSize),
          Container(
            constraints: BoxConstraints(
              minHeight: 50.0 * 4,
            ),
            decoration: context.boxDecoration(
              color: context.whiteColor,
            ),
            width: context.mediaWidth - context.edgeSizeDouble,
            padding: context.edgeAll10,
            child: Wrap(
              children: [
                ...select.value.asMap().keys.map<Widget>((index) {
                  final item = select.value[index];
                  return buildItem(
                    context: context,
                    text: item,
                    onPress: (text) {
                      if (select.value.contains(text)) {
                        final mList = select.value;
                        mList.remove(text);
                        select.value = [...mList];
                      }
                    },
                  );
                }).toList()
              ],
            ),
          ),
          SizedBox(height: context.edgeSize),
          MnemonicCard(
            mnemonic: randomList.value,
            selected: select.value,
            onSelect: (text) {
              if (!select.value.contains(text)) {
                select.value = [...select.value, text];
              }
            },
          ),
          SizedBox(height: context.edgeSizeDouble),
          CSButton(
            disabled: select.value.length != 12,
            label: tr('global:btn_confirm'),
            onPressed: () {
              if (isInvalid && select.value.length == 12) {
                Toast.show(tr('wallet:backup_msg_error'));
              }

              if (!isInvalid) {
                viewModel.backupSuccess();
                Toast.show(tr('wallet:backup_msg_success'));
                AppNavigator.gotoTabBar();
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildItem({
    BuildContext context,
    String text,
    Function(String item) onPress,
  }) {
    return InkWell(
      onTap: () {
        onPress(text);
      },
      borderRadius: context.radiusAll5,
      child: CSContainer(
        width: null,
        radius: 5,
        margin: context.edgeRight8.copyWith(bottom: 10),
        padding: context.edgeAll5,
        secondary: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text.split('_')[0] ?? '',
              style: context.textBody(
                color: context.secondaryColor,
                bold: true,
              ),
            ),
            Container(
              decoration: context.boxDecoration(
                color: context.primaryColor,
                radius: 5,
              ),
              margin: context.edgeLeft8,
              padding: EdgeInsets.all(3),
              child: Icon(
                Icons.close,
                size: 15,
                color: context.bodyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = useState(_BackupStep.intro);
    final select = useState<List<String>>([]);
    final randomList = useState<List<String>>([]);

    useEffect(() {
      DabankWindowManager.useSecure();
      return () {
        DabankWindowManager.disuseSecure();
      };
    }, []);

    // VALID 下面会单独判断 因为参数 不一样
    final viewBuild =
        step.value == _BackupStep.intro ? buildTipView : buildMnemonicView;

    return WillPopScope(
      onWillPop: () {
        if (step.value == _BackupStep.intro) {
          AppNavigator.gotoTabBar();
        } else if (step.value == _BackupStep.showMnemonic) {
          step.value = _BackupStep.intro;
        } else if (step.value == _BackupStep.validateMnemonic) {
          randomList.value = [];
          select.value = [];
          step.value = _BackupStep.showMnemonic;
        }
        return Future.value(false);
      },
      child: CSScaffold(
        title: tr('wallet:backup_title'),
        scrollable: true,
        actions: [
          if (AppConstants.isBeta)
            CSButton(
              flat: true,
              padding: context.edgeAll,
              label: tr('wallet:backup_title'),
              onPressed: () {
                copyTextToClipboard(mnemonicList.join(' '));
                Toast.show(tr('global:msg_copy_success'));
              },
            )
        ],
        child: StoreConnector<AppState, WalletBackupVM>(
          distinct: true,
          converter: WalletBackupVM.fromStore,
          builder: (context, viewModel) => Container(
            child: step.value == _BackupStep.validateMnemonic
                ? buildConfirmView(context, viewModel, select, randomList)
                : viewBuild(context, step, viewModel),
          ),
        ),
      ),
    );
  }
}
