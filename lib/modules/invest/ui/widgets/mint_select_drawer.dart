part of invest_ui_module;

class MintSelectDrawer extends StatelessWidget {
  const MintSelectDrawer({
    @required this.mints,
    @required this.activeMintId,
    @required this.onLoadMint,
  });

  final List<MintItem> mints;
  final int activeMintId;
  final void Function(MintItem mint) onLoadMint;

  Widget buildItem(
    BuildContext context,
    MintItem item,
    int select,
  ) {
    final isSelected = activeMintId == item.id;
    final mintName = item.nameByLang(tr('global:language_api'));

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onLoadMint(item);
      },
      child: CSContainer(
        margin: context.edgeBottom,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mintName,
                        style: context.textBody(bold: true),
                      )
                    ],
                  ),
                  SizedBox(height: context.edgeSizeHalf),
                  Text(
                    'Make up',
                    style: context.textSmall(),
                  ),
                ],
              ),
            ),
            if (isSelected)
              CSButtonIcon(
                padding: EdgeInsets.only(
                  right: 2,
                  top: 1,
                ),
                containerSize: 16,
                size: 6,
                borderRadius: 16,
                icon: CSIcons.WalletCheck,
              )
            else
              Icon(
                CSIcons.More,
                size: 12,
                color: context.bodyColor,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: context.edgeAll,
        color: context.bgSecondaryColor,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: mints
                      .map((item) => buildItem(context, item, activeMintId))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
