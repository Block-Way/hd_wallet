part of widgets;

class CSEmpty extends HookWidget {
  const CSEmpty({
    Key key,
    this.header,
    this.imageUrl,
    this.label,
    this.btnText,
    this.isLoading = false,
    this.showButton = false,
    this.heightFromTop = 60,
    this.onPressed,
    this.width = 156,
    this.height = 156,
  }) : super(key: key);

  final Widget header;
  final String imageUrl;
  final String label;
  final String btnText;
  final bool isLoading;
  final bool showButton;
  final double heightFromTop;
  final void Function() onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null)
          Align(alignment: Alignment.centerLeft, child: header),
        SizedBox(height: heightFromTop),
        if (isLoading == false)
          Image.asset(
            imageUrl ?? 'assets/images/empty_record.png',
            fit: BoxFit.contain,
            height: height,
            width: width,
          ),
        if (isLoading == true)
          RiveAnimation(
            fileName: 'loading',
            animation: 'Untitled 1',
            width: 150,
          ),
        SizedBox(height: 30),
        if (isLoading == false)
          Text(
            label ?? '',
            style: context.textSecondary(
              color: context.placeholderColor,
            ),
          ),
        if (showButton == true)
          CSButton(
            label: btnText,
            backgroundColor: context.primaryColor,
            borderRadius: 25,
            onPressed: onPressed,
            margin: EdgeInsets.only(top: 30),
          ),
        SizedBox(height: 30),
      ],
    );
  }
}
