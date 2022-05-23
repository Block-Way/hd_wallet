part of widgets;

class CSBadge extends StatelessWidget {
  const CSBadge({
    Key key,
    this.size = 10,
    this.margin,
    this.color,
  }) : super(key: key);

  final double size;
  final EdgeInsets margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? context.edgeHorizontal5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: color ?? context.redColor,
      ),
      child: SizedBox(
        height: size,
        width: size,
      ),
    );
  }
}
