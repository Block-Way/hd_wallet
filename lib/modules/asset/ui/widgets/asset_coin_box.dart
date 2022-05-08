part of asset_ui_module;

class AssetCoinBox extends StatelessWidget {
  const AssetCoinBox({
    @required this.title,
    @required this.coinInfo,
    this.titleAction,
    this.onPress,
    Key key,
  }) : super(key: key);

  final String title;
  final Widget titleAction;
  final AssetCoin coinInfo;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return FormBox(
      type: FormBoxType.child,
      title: title,
      titleAction: titleAction,
      child: CSContainer(
        margin: EdgeInsets.zero,
        padding: context.edgeAll.copyWith(top: 18, bottom: 18),
        onTap: onPress,
        child: Row(
          key: ValueKey('$onPress'),
          children: [
            CSImage(
              coinInfo?.iconUrl ?? '',
              fallbackUrl: coinInfo?.iconLocal,
              width: 30,
              height: 30,
              radius: 30,
              fit: BoxFit.contain,
              bordered: true,
            ),
            SizedBox(width: 10),
            Text(
              coinInfo?.name ?? '',
              style: context.textBody(bold: true),
            ),
            SizedBox(width: 10),
            if (coinInfo?.fullName != null)
              Text(
                coinInfo.fullName,
                style: context.textSecondary(),
              ),
            Spacer(),
            if (coinInfo != null && onPress != null)
              Padding(
                padding: context.edgeLeft8,
                child: Icon(
                  CSIcons.More,
                  size: 12,
                  color: context.bodyColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
