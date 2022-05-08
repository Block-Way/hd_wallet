part of widgets;

class FormBoxPhone extends HookWidget {
  const FormBoxPhone({
    @required this.controller,
    Key key,
    this.maxLength = 15,
    this.hintText,
    this.autoFocus = false,
    this.validator,
    this.title,
    this.margin,
    this.onChangeCountry,
    this.selectCode,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final String hintText;
  final String title;
  final bool autoFocus;
  final FieldValidator validator;
  final EdgeInsetsGeometry margin;
  final Function(String country) onChangeCountry;
  final String selectCode;

  @override
  Widget build(BuildContext context) {
    final codeList = useState<List>([]);
    final code = useState('86');

    void countryCode() {
      rootBundle.loadString('assets/json/countries.json').then((value) {
        final list = json.decode(value) as List;
        codeList.value = list;
      });
    }

    useEffect(() {
      countryCode();

      return;
    }, []);

    void showDialog() {
      final name = context.locale;
      showCSBottomSheet(
          context,
          (context) => ListView(
                children: [
                  Padding(
                    padding: context.edgeHorizontal,
                    child: Text(
                      title,
                      style: context.textBody(bold: true),
                    ),
                  ),
                  ...codeList.value
                      .map((e) => CSButton(
                            label: '+${e['id']} ${e[name.toString()]}',
                            flat: true,
                            onPressed: () {
                              code.value = e['id'].toString();
                              AppNavigator.goBack();
                              onChangeCountry(e['id'].toString());
                            },
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            alignment: MainAxisAlignment.start,
                          ))
                      .toList(),
                ],
              ));
    }

    return FormBox(
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: context.edgeSize,
            vertical: 5,
          ),
      type: FormBoxType.inputNumber,
      title: title,
      autoFocus: autoFocus,
      validator: validator,
      controller: controller,
      hintText: hintText,
      inputLeftWidget: InkWell(
          onTap: () {
            showDialog();
          },
          child: Row(
            children: [
              Text(
                '+${code.value}',
                style: context.textBody(),
              ),
              Padding(
                padding: context.edgeLeft,
                child: Icon(
                  CSIcons.ArrowDown,
                  size: 8,
                  color: context.bodyColor,
                ),
              ),
              Container(
                height: 14,
                width: 1,
                margin: context.edgeHorizontal,
                color: Color(0xFFeeeeee),
              )
            ],
          )),
    );
  }
}
