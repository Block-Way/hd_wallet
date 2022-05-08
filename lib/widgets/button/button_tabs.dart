part of widgets;

class CSButtonTabsItem<T> {
  CSButtonTabsItem({
    @required this.id,
    @required this.label,
    this.value,
  });

  final String id;
  final String label;
  final T value;
}

class CSButtonTabs<T> extends HookWidget {
  const CSButtonTabs({
    @required this.items,
    @required this.selectedId,
    this.margin,
    this.onSelectedId,
    this.onSelectedValue,
  }) : assert(items != null);

  final EdgeInsets margin;
  final String selectedId;
  final List<CSButtonTabsItem<T>> items;
  final Function(String id) onSelectedId;
  final Function(T value) onSelectedValue;

  @override
  Widget build(BuildContext context) {
    final scrollController = useAutoScrollController(
      axis: Axis.horizontal,
    );

    useEffect(() {
      scrollController.scrollToIndex(
        items.indexWhere((element) => element.id == selectedId),
        preferPosition: AutoScrollPosition.begin,
      );

      return null;
    }, [selectedId]);

    return Container(
      margin: margin,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items
              .asMap()
              .entries
              .map(
                (item) => AutoScrollTag(
                  key: Key(item.value.id),
                  index: item.key,
                  controller: scrollController,
                  child: InkWell(
                    onTap: () {
                      if (item.value.id == selectedId) {
                        return;
                      }
                      scrollController.scrollToIndex(
                        item.key,
                        preferPosition: AutoScrollPosition.begin,
                      );
                      if (onSelectedId != null) {
                        onSelectedId(item.value.id);
                      }
                      if (onSelectedValue != null) {
                        onSelectedValue(item.value.value);
                      }
                    },
                    child: Container(
                      padding: context.edgeAll.copyWith(
                        bottom: 10,
                        top: 10,
                        left: item.key == 0 ? 0 : context.edgeSize,
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.value.label,
                            style: context.textBody(
                              bold: selectedId == item.value.id,
                              color: selectedId == item.value.id
                                  ? context.bodyColor
                                  : context.labelColor,
                            ),
                          ),
                          SizedBox(height: context.edgeSize),
                          if (selectedId == item.value.id)
                            Container(
                              width: 25,
                              height: 2,
                              decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            )
                          else
                            Container(height: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
