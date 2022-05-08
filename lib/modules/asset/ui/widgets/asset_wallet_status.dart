part of asset_ui_module;

class AssetWalletStatus extends HookWidget {
  const AssetWalletStatus({
    @required this.status,
    @required this.onPressed,
  }) : assert(status != null);

  final WalletStatus status;
  final void Function() onPressed;

  String get statusTransKey {
    switch (status) {
      case WalletStatus.notSynced:
        return 'wallet:wallet_status_not_synced';
      case WalletStatus.synced:
        return 'wallet:wallet_status_synced';
      case WalletStatus.unknown:
        return 'wallet:wallet_status_unknown';
      default:
        return 'wallet:wallet_status_loading';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSynced = status == WalletStatus.synced;
    final isNotSynced = status == WalletStatus.notSynced;
    final needSync =
        status != WalletStatus.synced && status != WalletStatus.loading;

    final statusColor = isSynced
        ? context.secondaryColor
        : isNotSynced
            ? context.redColor
            : context.labelColor;

    final statusIcon = isSynced
        ? CSIcons.Check
        : isNotSynced
            ? CSIcons.Delete
            : CSIcons.Refresh;

    return CSContainer(
      padding: context.edgeAll8,
      margin: EdgeInsets.zero,
      width: null,
      decoration: context.boxDecorationOnlyLeft(
        color: context.blackColor.withOpacity(0.02),
        radius: 14,
      ),
      onTap: needSync ? onPressed : null,
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            margin: context.edgeRight5,
            decoration: context.boxDecoration(color: statusColor, radius: 14),
            alignment: Alignment.center,
            child: Icon(
              statusIcon,
              size: 8,
              color: context.whiteColor,
            ),
          ),
          Text(
            tr(statusTransKey),
            style: context.textSmall(color: statusColor),
          ),
          if (needSync)
            Icon(
              CSIcons.More,
              size: 10,
              color: statusColor,
            ),
        ],
      ),
    );
  }
}
