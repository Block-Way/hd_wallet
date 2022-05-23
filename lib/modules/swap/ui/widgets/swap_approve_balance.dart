part of swap_ui_module;

class SwapApproveBalance extends StatelessWidget {
  const SwapApproveBalance({
    @required this.approveBalance,
    @required this.isRefreshing,
    @required this.onGetApproveBalance,
    @required this.onResetApproveBalance,
    Key key,
    this.padding,
  }) : super(key: key);

  final bool isRefreshing;
  final double approveBalance;
  final EdgeInsetsGeometry padding;
  final void Function() onGetApproveBalance;
  final void Function() onResetApproveBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: context.edgeAll.copyWith(bottom: 0),
              child: Text(
                tr('swap:create_lbl_approve_balance'),
                style: context.textBody(
                  bold: true,
                  color: context.labelColor,
                ),
              ),
            ),
            if (approveBalance == null && isRefreshing == false)
              CSButton(
                label: tr('swap:create_btn_approve_balance'),
                flat: true,
                padding: context.edgeAll.copyWith(bottom: 0),
                textStyle: context.textSecondary().copyWith(
                      color: context.secondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                onPressed: () {
                  onGetApproveBalance();
                },
              ),
          ],
        ),
        CSContainer(
          padding: context.edgeAll.copyWith(top: 18, bottom: 18),
          height: 66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isRefreshing == false)
                Text(
                  approveBalance?.toString() ?? '-',
                  style: context.textBody(),
                ),
              if (isRefreshing == true)
                CSProgressIndicator(
                  size: context.edgeSize,
                  strokeWidth: 1.0,
                  backgroundColor: Colors.transparent,
                  color: context.blackColor,
                ),
              Spacer(),
              if (approveBalance != null && approveBalance > 0)
                CSButtonIcon(
                  padding: EdgeInsets.zero,
                  containerSize: 28,
                  size: 18,
                  borderRadius: 8,
                  icon: CSIcons.Approve,
                  color: context.bodyColor,
                  onPressed: () {
                    onResetApproveBalance();
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
