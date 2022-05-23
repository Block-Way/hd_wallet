part of hdkey_ui_module;

class HDKeyMnemonicImportDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final step = useState(0);
    final walletSelect = useState(0);
    final name = useTextEditingController(text: '');
    final pwd = useTextEditingController(text: '');

    if (step.value == 0) {
      return buildSelectWallet(context, walletSelect, step);
    } else if (step.value == 1) {
      return buildEditName(context, step, name);
    } else {
      return buildPwd(context, step, pwd);
    }
  }

  Widget buildSelectWallet(
    BuildContext context,
    ValueNotifier<int> walletSelect,
    ValueNotifier<int> step,
  ) {
    final itemWidth = (context.mediaWidth - context.edgeSizeDouble) / 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: context.edgeBottom20,
          child: Text(
            '将助记词导入（备份）到硬件设备中',
            style: context.textSecondary(),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: List.generate(
                15,
                (index) => InkWell(
                  onTap: () {
                    walletSelect.value = index;
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 15),
                    width: itemWidth,
                    padding: EdgeInsets.symmetric(
                        horizontal: context.edgeSize, vertical: 25),
                    decoration: BoxDecoration(
                      color: index == walletSelect.value
                          ? context.primaryColor
                          : context.bgSecondaryColor,
                      borderRadius: context.radiusAll10,
                    ),
                    child: Text(
                      'aab',
                      style: context.textBody(
                          bold: true,
                          color: index == walletSelect.value
                              ? context.whiteColor
                              : context.bodyColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: context.edgeHorizontal,
          child: CSButton(
            label: '确认导入',
            fullwidth: true,
            borderRadius: 10,
            onPressed: () {
              step.value = 1;
            },
          ),
        ),
      ],
    );
  }

  Widget buildEditName(BuildContext context, ValueNotifier<int> step,
      TextEditingController name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormBox(
          type: FormBoxType.inputText,
          title: '设置备份名称',
          hintText: '请输入备份名称，限10字符',
          maxLength: 10,
          validator: RequiredValidator(errorText: 'This is required'),
          controller: name,
        ),
        CSButton(
          label: '确认导入',
          onPressed: () {
            step.value = 2;
          },
        ),
      ],
    );
  }

  Widget buildPwd(BuildContext context, ValueNotifier<int> step,
      TextEditingController pwd) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormBoxPassword(
          autoFocus: true,
          title: tr('wallet:lbl_verify_pwd'),
          titleStyle: context.textBody(
            bold: true,
          ),
          controller: pwd,
          hintText: tr('wallet:hint_verify_pwd'),
        ),
        CSButton(
          label: '确认导入',
          onPressed: () {
            Toast.show('todo');
          },
        ),
      ],
    );
  }
}
