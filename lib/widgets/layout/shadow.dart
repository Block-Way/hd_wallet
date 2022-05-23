part of widgets;

class DividerShadow extends StatelessWidget {
  const DividerShadow();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: context.bgPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: context.blackColor.withOpacity(0.1),
            blurRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
      ),
    );
  }
}
