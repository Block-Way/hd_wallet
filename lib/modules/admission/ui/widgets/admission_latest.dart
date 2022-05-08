part of admission_ui_module;

class AdmissionLatest extends StatelessWidget {
  const AdmissionLatest({
    @required this.list,
    @required this.hasWallet,
    Key key,
  }) : super(key: key);
  final List<AdmissionInfo> list;
  final bool hasWallet;

  Widget buildItem(BuildContext context, AdmissionInfo item) {
    final condition = item.transferCondition;

    if (condition == null || condition.address == null) {
      return SizedBox();
    }

    final isSuccess = condition.progressPercent >= 1;
    final btnDisable = !item.isRunning || isSuccess;

    final startTime = formatDate(
      DateTime.fromMillisecondsSinceEpoch((item.startTime ?? 0) * 1000),
      'MM.dd HH:mm',
    );

    final endTime = formatDate(
      DateTime.fromMillisecondsSinceEpoch((item.endTime ?? 0) * 1000),
      'MM.dd HH:mm',
    );
    final width = context.mediaWidth - context.edgeSize * 4;
    final progressLeftLbl = condition.progressCountLbl;
    final progressRightLbl =
        '${(condition.progressPercent * 100).toInt()}/100%';

    final timeLbl = tr('admission:list_item_lbl_time',
        namedArgs: {'start': startTime, 'end': endTime});

    final btnLbl = item.isRunning
        ? (isSuccess
            ? tr('admission:list_item_btn_is_end')
            : tr('admission:list_item_btn_join'))
        : item.notStart
            ? tr('admission:list_item_btn_not_start')
            : tr('admission:list_item_btn_is_end');

    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name ?? '',
            style: context.textMedium(bold: true),
          ),
          SizedBox(height: 20),
          CSHorizontalProgress(
            width: width,
            height: 6,
            value: condition.progressPercent,
            valueColor: context.greenColor,
            backgroundColor: Color(0xFFe5f8f1),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                progressLeftLbl,
                style: context.textSmall(
                  color: item.isRunning
                      ? context.greenColor
                      : context.secondaryColor,
                ),
              ),
              Spacer(),
              Text(progressRightLbl, style: context.textSmall()),
            ],
          ),
          SizedBox(height: 20),
          CSButton(
            height: 40,
            fullwidth: true,
            label: btnLbl,
            disabled: btnDisable,
            onPressed: btnDisable
                ? null
                : () {
                    if (hasWallet) {
                      AdmissionCreatePage.open(item);
                    } else {
                      AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
                    }
                  },
          ),
          SizedBox(height: 10),
          if (item.isEnd || isSuccess)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.5,
                    color: Color(0xffeeeeee),
                    width: 50,
                    margin: context.edgeRight8,
                  ),
                  Text(
                    isSuccess
                        ? tr('admission:list_item_status_success')
                        : tr('admission:list_item_status_failed'),
                    style: context.textSmall(
                      color: isSuccess
                          ? context.greenColor
                          : context.secondaryColor,
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: Color(0xffeeeeee),
                    width: 50,
                    margin: context.edgeLeft8,
                  ),
                ],
              ),
            )
          else
            Center(
              child: Text(timeLbl, style: context.textSmall()),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (list == null || list.isEmpty) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list
          .map(
            (e) => buildItem(context, e),
          )
          .toList(),
    );
  }
}
