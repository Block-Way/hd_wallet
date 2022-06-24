part of trade_ui_module;

class ChartKLineResolutions extends HookWidget {
  const ChartKLineResolutions({
    required this.height,
    required this.color,
    required this.selected,
    required this.onSelected,
  });

  final double height;
  final ResolutionItem selected;
  final Color color;
  final Function(ResolutionItem selected) onSelected;

  @override
  Widget build(BuildContext context) {
    final scrollController = useAutoScrollController(
      axis: Axis.horizontal,
    );

    useEffect(() {
      scrollController.scrollToIndex(
        kChartResolutions.indexWhere((e) => e.id == selected.id),
        preferPosition: AutoScrollPosition.begin,
      );

      return null;
    }, [selected]);

    return Container(
      margin: context.edgeHorizontal,
      height: height,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: kChartResolutions.asMap().entries.map(
            (item) {
              final value = item.value;
              final index = item.key;
              return AutoScrollTag(
                key: Key(value.id ?? ''),
                index: index,
                controller: scrollController,
                child: CSButton(
                  flat: true,
                  alignment: MainAxisAlignment.start,
                  padding: context.edgeHorizontal10
                      .copyWith(left: index == 0 ? 0 : 10),
                  textStyle: context.textSmall(
                    color:
                        value.id == selected.id ? context.primaryColor : color,
                    bold: true,
                    fontWeight: FontWeight.normal,
                  ),
                  onPressed: () {
                    if (value.id == selected.id) {
                      return;
                    }
                    scrollController.scrollToIndex(
                      index,
                      preferPosition: AutoScrollPosition.begin,
                    );
                    if (onSelected != null) {
                      onSelected(value);
                    }
                  },
                  label: tr(value.label!),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
