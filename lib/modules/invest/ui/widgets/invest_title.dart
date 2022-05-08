part of invest_ui_module;

class InvestTitle extends StatelessWidget {
  const InvestTitle({
    @required this.onPressed,
    this.activeMint,
  });

  final MintItem activeMint;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      margin: EdgeInsets.zero,
      padding: context.edgeVertical,
      decoration: context.boxDecoration(color: Colors.transparent),
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(width: context.edgeSize),
          Icon(
            CSIcons.Hamburger,
            size: 20,
            color: context.bodyColor,
          ),
          SizedBox(width: 10),
          Text(
            activeMint?.nameByLang(
                  tr('global:language_api'),
                ) ??
                '',
            style: context.textBig(
              bold: true,
              color: context.bodyColor,
            ),
          ),
        ],
      ),
    );
  }
}
