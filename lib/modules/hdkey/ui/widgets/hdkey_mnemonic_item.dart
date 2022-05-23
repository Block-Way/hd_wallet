part of hdkey_ui_module;

class HDKeyMnemonicItem extends HookWidget {
  const HDKeyMnemonicItem({
    @required this.item,
    this.onDelete,
    this.isRecoverDisable,
  });

  final Wallet item;
  final Function onDelete;
  final bool isRecoverDisable;

  void showMoreDialog(BuildContext context) {
    showCSBottomSheet(
      context,
      (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: context.edgeHorizontal,
            child: Text(
              tr('更多操作'),
              style: context.textBody(
                bold: true,
                color: context.labelColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          FormCell(
            label: '删除助记词',
            onPress: () {
              AppNavigator.goBack();
              onDelete();
            },
          ),
        ],
      ),
    );
  }

  Widget renderButton(
    BuildContext context, {
    String btnText,
    Function() onPress,
  }) {
    final color = onPress != null
        ? context.whiteColor
        : Color.fromRGBO(255, 255, 255, 0.4);
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: onPress,
          child: Container(
            margin: context.edgeHorizontal10,
            constraints: BoxConstraints(minWidth: context.mediaWidth * 0.25),
            decoration: BoxDecoration(
                border: Border.all(color: color),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                btnText,
                maxLines: 1,
                style: context.textSecondary(
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = item.isDevice
        ? [Color(0xFF8D939F), Color(0xFF545A66)]
        : [Color(0xFFFFC05B), Color(0xFFFF8C2E)];

    return Container(
      width: double.infinity,
      margin: context.edgeBottom,
      padding: context.edgeAll.copyWith(top: 20, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: context.radiusAll10,
        gradient: LinearGradient(
          colors: bgColor,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              item.name,
              style: context.textBody(
                bold: true,
                color: context.whiteColor,
              ),
            ),
            Spacer(),
            IconButton(
                icon:
                    Icon(CSIcons.EvenMore, size: 20, color: context.whiteColor),
                onPressed: () {
                  showMoreDialog(context);
                }),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: List.generate(
            5,
            (index) => Expanded(
              child: Text(
                '****',
                style: context.textBody(
                  color: context.whiteColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            renderButton(
              context,
              btnText: '导出',
              onPress: item.isDevice
                  ? null
                  : () {
                      //
                    },
            ),
            Container(
              height: 12,
              width: 1,
              color: context.whiteColor.withOpacity(0.1),
            ),
            renderButton(
              context,
              btnText: '恢复钱包',
              onPress: item.isDevice || isRecoverDisable
                  ? null
                  : () {
                      //
                    },
            ),
          ],
        ),
      ]),
    );
  }
}
