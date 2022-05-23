part of invest_ui_module;

class LoadingHeader extends StatelessWidget {
  const LoadingHeader({
    Key key,
    this.hasWallet,
  }) : super(key: key);

  final bool hasWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.edgeAll,
      height: 80,
      alignment: Alignment.center,
      child: Text(
        hasWallet ? tr('global:lbl_loading') : '',
        style: context.textSmall(color: context.bodyColor),
      ),
    );
  }
}
