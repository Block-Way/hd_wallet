part of widgets;

class CSButtonMenuItem<T> {
  CSButtonMenuItem({
    @required this.id,
    @required this.label,
    this.value,
  });

  final String id;
  final String label;
  final T value;
}

class CSButtonMenu<T> extends HookWidget {
  const CSButtonMenu({
    @required this.items,
    @required this.selectedId,
    this.textColor,
    this.selectedColor,
    this.onSelectedId,
  }) : assert(items != null);

  final String selectedId;
  final Color textColor;
  final Color selectedColor;
  final List<CSButtonMenuItem<T>> items;
  final Function(String id) onSelectedId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .asMap()
          .entries
          .map(
            (item) => Expanded(
              child: InkWell(
                onTap: () {
                  if (item.value.id == selectedId) {
                    return;
                  }
                  if (onSelectedId != null) {
                    onSelectedId(item.value.id);
                  }
                },
                child: Container(
                  padding: context.edgeAll.copyWith(bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        item.value.label,
                        style: context.textBody(
                          bold: selectedId == item.value.id,
                          color: selectedId == item.value.id
                              ? selectedColor ?? context.bodyColor
                              : textColor ?? context.labelColor,
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
    );
  }
}
