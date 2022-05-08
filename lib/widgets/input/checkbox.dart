part of widgets;

class CSCheckBox extends HookWidget {
  const CSCheckBox({
    @required this.label,
    @required this.value,
    @required this.onChanged,
    Key key,
    this.labelChildren,
    this.alignment,
  }) : super(key: key);

  final String label;
  final bool value;
  final MainAxisAlignment alignment;
  final InlineSpan labelChildren;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(value);

    void handleOnChange() {
      isChecked.value = !isChecked.value;
      onChanged(isChecked.value);
    }

    return InkWell(
      onTap: handleOnChange,
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: SizedBox(
              width: 11,
              height: 11,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: isChecked.value
                        ? context.primaryColor
                        : context.labelColor,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.transparent,
                  ),
                  child: Checkbox(
                    value: isChecked.value,
                    onChanged: (_) => handleOnChange(),
                    activeColor: Colors.transparent,
                    checkColor: context.primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          RichText(
            text: TextSpan(
              text: label,
              style: context.textSecondary(),
              children: labelChildren != null ? [labelChildren] : null,
            ),
          ),
        ],
      ),
    );
  }
}
