part of wallet_ui_module;

class _Item {
  _Item(this.tip, this.image);
  final String tip;
  final String image;
}

class MnemonicBackupImgTip extends StatelessWidget {
  const MnemonicBackupImgTip({
    this.width = 100,
  });

  final double width;

  Widget renderItem(BuildContext context, _Item item, double iconSize) {
    return SizedBox(
      width: (width - context.edgeSizeDouble) * 0.5,
      child: Padding(
        padding: context.edgeAll10,
        child: Column(
          children: [
            Image.asset(
              item.image,
              width: iconSize,
              height: iconSize,
            ),
            SizedBox(height: 10),
            Text(
              item.tip,
              style: context.textSecondary(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = width * 0.2;

    final list = [
      _Item(tr('wallet:backup_image_tip1'),
          'assets/images/mnemonic_backup_tip1.png'),
      _Item(tr('wallet:backup_image_tip2'),
          'assets/images/mnemonic_backup_tip2.png'),
      _Item(tr('wallet:backup_image_tip3'),
          'assets/images/mnemonic_backup_tip3.png'),
      _Item(tr('wallet:backup_image_tip4'),
          'assets/images/mnemonic_backup_tip4.png')
    ];

    return Padding(
      padding: context.edgeHorizontal,
      child: Wrap(
        children: list.map((e) => renderItem(context, e, iconSize)).toList(),
      ),
    );
  }
}
