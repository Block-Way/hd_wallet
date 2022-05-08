part of project_ui_module;

class ProjectPoolPlanItem extends HookWidget {
  const ProjectPoolPlanItem({
    @required this.item,
    Key key,
    this.editable = true,
    this.onPress,
    this.monthCallback,
    this.ratioCallback,
    this.cacheMonth = '',
    this.cacheRatio = '',
  }) : super(key: key);

  final ProjectCreateMint item;
  final bool editable;
  final Function(int index) onPress;
  final Function(String text, int index) monthCallback;
  final Function(String text, int index) ratioCallback;
  final String cacheRatio;
  final String cacheMonth;

  @override
  Widget build(BuildContext context) {
    final monthController = useTextEditingController(text: item.month);
    final ratioController = useTextEditingController(text: item.ratio);

    return Container(
      key: Key('${item.index}'),
      margin: EdgeInsets.symmetric(
        horizontal: context.edgeSize,
        vertical: 10,
      ),
      padding: context.edgeAll,
      decoration: context.boxDecoration(
        color: context.bgSecondaryColor,
        radius: 10,
      ),
      child: Row(
        children: [
          Column(
            children: [
              poolSetInput(
                context,
                hintText: tr('project:create_input_pool_month'),
                rightLabel: tr('global:lbl_month'),
                editable: editable,
                controller: monthController,
                callback: (text) {
                  monthCallback(text.toString(), item.index);
                },
              ),
              SizedBox(height: 10),
              poolSetInput(
                context,
                hintText: tr('project:create_input_pool_ratio'),
                rightLabel: '%',
                editable: editable,
                controller: ratioController,
                callback: (text) {
                  ratioCallback(text.toString(), item.index);
                },
                isRatio: true,
              ),
            ],
          ),
          if (item.index == 1)
            Container()
          else
            InkWell(
              onTap: () {
                onPress(item.index);
              },
              child: Padding(
                padding: context.edgeLeft10,
                child: CSImage(
                  'assets/images/project_remove.png',
                  width: 20,
                  height: 20,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget poolSetInput(
  BuildContext context, {
  String hintText,
  String rightLabel,
  bool editable,
  TextEditingController controller,
  Function callback,
  bool isRatio = false,
}) {
  return Container(
    key: Key(rightLabel),
    height: 44,
    width: context.mediaWidth - 90,
    padding: context.edgeHorizontal10,
    decoration: context.boxDecoration(
      color: context.whiteColor,
      radius: 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            autocorrect: false, //是否自动更正
            enabled: editable,
            onChanged: (text) {
              callback(text);
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              isDense: true,
              hintStyle: context.textPlaceholder(),
              counterText: '',
            ),
            inputFormatters: isRatio
                ? [
                    NumberTextInputFormatter(
                      maxDecimal: 3,
                      maxInteger: 10,
                    ),
                  ]
                : [
                    NumberTextInputFormatter(
                      maxDecimal: 3,
                      maxInteger: 8,
                    ),
                  ],
            style: context.textBody(),
          ),
        ),
        Text(
          rightLabel,
          style: context.textBody(bold: true),
        ),
      ],
    ),
  );
}
