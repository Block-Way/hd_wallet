part of widgets;

class CSAmountSelect extends HookWidget {
  const CSAmountSelect({
    @required this.maxChanges,
    @required this.ratioChanges,
    @required this.onChanged,
    @required this.selectedSide,
    Key key,
  }) : super(key: key);

  final Stream<double> maxChanges;
  final Stream<String> ratioChanges;
  final Function(double amount, String ratio) onChanged;
  final int selectedSide;

  @override
  Widget build(BuildContext context) {
    final ratioList = ['25', '50', '75', '100'];
    final selectedRatio = useStream(ratioChanges, initialData: '0');
    final maxValue = useStream(maxChanges, initialData: 0.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...ratioList.map(
          (ratio) => CSButton(
            label: '$ratio%',
            padding: EdgeInsets.zero,
            width: 42,
            height: 26,
            borderRadius: 5,
            bordered: selectedRatio.data != ratio,
            borderColor: Color(0xFFCCCCCC),
            borderWidth: 0.5,
            textStyle: context.textSmall(
              color: selectedRatio.data == ratio
                  ? context.whiteColor
                  : context.secondaryColor,
            ),
            backgroundColor: selectedRatio.data == ratio
                ? selectedSide == 0
                    ? context.greenColor
                    : context.redColor
                : context.whiteColor,
            onPressed: () {
              final value = NumberUtil.multiply<double>(
                maxValue.data,
                NumberUtil.divide(ratio, 100),
              );
              onChanged(value, ratio);
            },
          ),
        ),
      ],
    );
  }
}
