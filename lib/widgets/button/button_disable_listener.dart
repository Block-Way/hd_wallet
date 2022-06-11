part of widgets;

class ButtonDisableListener extends HookWidget {
  const ButtonDisableListener({
    required this.listenValues,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final List<TextEditingController> listenValues;
  final Widget Function(bool disabled) builder;

  @override
  Widget build(BuildContext context) {
    final disable = useState(true);

    void checkInput() {
      for (final item in listenValues) {
        if (item == null || item.text == null || item.text.isEmpty) {
          disable.value = true;
          return;
        }
      }
      disable.value = false;
    }

    void dispose() {
      try {
        for (final item in listenValues) {
          if (item != null) {
            item.removeListener(checkInput);
          }
        }
      } catch (_) {}
    }

    useEffect(() {
      for (final item in listenValues) {
        if (item != null) {
          item.addListener(checkInput);
        }
      }
      checkInput();
      return dispose;
    }, [listenValues]);

    return builder(disable.value);
  }
}
