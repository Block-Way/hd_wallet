part of invest_ui_module;

enum AirdropStep {
  /// Yellow: Current step
  current,

  /// Disabled: Next step
  next,

  /// Green: Done
  done,
}

/// Status Icon/Step Number + Text + Icon
class AirdropStepCard extends StatelessWidget {
  const AirdropStepCard({
    Key key,
    this.step,
    this.index,
  }) : super(key: key);

  final AirdropStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDone = step == AirdropStep.done;
    return Container(
      height: 55,
      decoration: context.boxDecoration(
        color: Color(0xFFfefcf3),
        radius: 8,
      ),
      margin: context.edgeTop,
      child: Stack(
        children: [
          Container(
            padding: context.edgeAll.copyWith(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Opacity(
              opacity: step == AirdropStep.next ? 0.3 : 1,
              child: Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    padding: isDone
                        ? EdgeInsets.only(
                            right: 2,
                            top: 1,
                          )
                        : EdgeInsets.zero,
                    margin: context.edgeRight8,
                    decoration: context.boxDecoration(
                      color: step == AirdropStep.done
                          ? context.greenColor
                          : context.primaryColor,
                      radius: 15,
                    ),
                    alignment: Alignment.center,
                    child: isDone
                        ? Icon(
                            CSIcons.WalletCheck,
                            size: 6,
                            color: context.whiteColor,
                          )
                        : Text(
                            index.toString(),
                            style: context.textTiny(
                              bold: true,
                              color: context.bodyColor,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Text(
                      tr(labelTransKey(step)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textSecondary(
                        color: Color(0xFF94820d),
                      ),
                    ),
                  ),
                  SizedBox(width: 34),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CSImage(
              imageUrl(step),
              width: 34,
              height: 34,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

String labelTransKey(AirdropStep step) {
  switch (step) {
    case AirdropStep.done:
      return 'invest:airdrop_step_lbl_join';
    case AirdropStep.current:
      return 'invest:airdrop_step_lbl_transfer';
    case AirdropStep.next:
      return 'invest:airdrop_step_lbl_wait';
    default:
      return '';
  }
}

String imageUrl(AirdropStep step) {
  switch (step) {
    case AirdropStep.done:
      return 'assets/images/airdrop_join.png';
    case AirdropStep.current:
      return 'assets/images/airdrop_transfer.png';
    case AirdropStep.next:
      return 'assets/images/airdrop_wait.png';
    default:
      return '';
  }
}
