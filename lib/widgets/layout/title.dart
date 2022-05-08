part of widgets;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    @required this.title,
    this.subtitle,
    this.brightness,
  }) : assert(title != null);

  final String title;
  final String subtitle;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? '',
          style: context.textMedium(
            bold: true,
            color: brightness == Brightness.dark ? context.whiteColor : null,
          ),
        ),
        if (subtitle != null) SizedBox(height: 2),
        if (subtitle != null)
          Text(
            subtitle,
            style: context.textSecondary(
              color: brightness == Brightness.dark
                  ? context.whiteColor
                  : context.labelColor,
            ),
          ),
      ],
    );
  }
}
