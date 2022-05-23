part of wallet_ui_module;

class MnemonicBackupMsgTip extends StatelessWidget {
  final tips = [
    tr('wallet:backup_rule_tip1'),
    tr('wallet:backup_rule_tip2'),
    tr('wallet:backup_rule_tip3'),
    tr('wallet:backup_rule_tip4'),
    tr('wallet:backup_rule_tip5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...tips
            .map(
              (tipText) => Padding(
                padding: context.edgeAll5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: context.edgeTop,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: context.radiusAll5,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tipText,
                        style: context.textSecondary().copyWith(
                              height: 2,
                              color: context.bodyColor,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
