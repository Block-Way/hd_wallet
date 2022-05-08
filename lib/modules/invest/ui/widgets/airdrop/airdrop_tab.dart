part of invest_ui_module;

enum AirdropStatus {
  noJoin,
  noTickets,
  waitOpen,
  noQualification,
  qualified,
}

class AirdropTab extends StatelessWidget {
  const AirdropTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const type = AirdropStatus.waitOpen;

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: context.boxDecoration(radius: 10),
          margin: context.edgeAll,
          padding: context.edgeAll.copyWith(top: 24, bottom: 24),
          constraints: BoxConstraints(
            minHeight: 370,
          ),
          child: Column(
            mainAxisAlignment: type == AirdropStatus.noQualification
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (type == AirdropStatus.waitOpen ||
                  type == AirdropStatus.qualified)
                CSImage(
                  'assets/images/airdrop_wait_bg.png',
                  width: 144,
                  height: 100,
                ),
              if (type == AirdropStatus.noQualification)
                CSImage(
                  'assets/images/airdrop_empty_bg.png',
                  width: 200,
                  height: 118,
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 30),
                child: Text(
                  airdropStatusKey(type),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: context.textSecondary(
                    bold: true,
                    color: context.bodyColor,
                  ),
                ),
              ),
              if (type == AirdropStatus.qualified) airdropDes(context),
              if (type == AirdropStatus.noJoin ||
                  type == AirdropStatus.noTickets ||
                  type == AirdropStatus.waitOpen)
                airdropStepColum(),
              if (type == AirdropStatus.noJoin ||
                  type == AirdropStatus.noTickets)
                CSButton(
                  label: type == AirdropStatus.noJoin
                      ? tr('invest:airdrop_btn_join')
                      : tr('invest:airdrop_btn_transfer'),
                  margin: EdgeInsets.only(top: 46),
                  onPressed: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget airdropStepColum() {
  return Column(
    children: const [
      AirdropStepCard(
        index: 1,
        step: AirdropStep.done,
      ),
      AirdropStepCard(
        index: 2,
        step: AirdropStep.current,
      ),
      AirdropStepCard(
        index: 3,
        step: AirdropStep.next,
      ),
    ],
  );
}

Widget airdropDes(BuildContext context) {
  return Container(
    decoration: context.boxDecoration(
      color: Color(0xFFfefcf3),
      radius: 8,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    child: Column(
      children: [
        ...[
          tr('invest:airdrop_lbl_wait_tips1'),
          tr('invest:airdrop_lbl_wait_tips2'),
        ].map(
          (label) => Text(
            label,
            style: context.textSecondary(
              color: Color(0xFF94820d),
              lineHeight: 1.77,
            ),
          ),
        ),
      ],
    ),
  );
}

String airdropStatusKey(AirdropStatus type) {
  switch (type) {
    case AirdropStatus.noJoin:
    case AirdropStatus.noTickets:
    case AirdropStatus.noQualification:
      return tr('invest:airdrop_lbl_no_join');
    case AirdropStatus.waitOpen:
      return tr('invest:airdrop_lbl_wait_open');
    case AirdropStatus.qualified:
      return tr('invest:airdrop_lbl_qualified');
    default:
      return '';
  }
}
