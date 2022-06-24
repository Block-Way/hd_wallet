part of widgets;

class SliverHeaderContainer extends SliverPersistentHeaderDelegate {
  SliverHeaderContainer({
    this.child,
    this.color,
    this.height = 50,
  });

  final Widget? child;
  final Color? color;
  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: color ?? context.bgScaffoldColor,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class SliverChildContainer extends SliverChildDelegate {
  SliverChildContainer({
    this.child,
    this.color,
    this.height = 50,
  });

  final Widget? child;
  final Color? color;
  final double height;

  @override
  Widget build(
    BuildContext context,
    int index,
  ) {
    return Container(
      color: color ?? context.bgScaffoldColor,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverChildDelegate oldDelegate) => false;
}
