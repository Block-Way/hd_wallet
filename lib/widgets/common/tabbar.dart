part of widgets;

class CSTabBar extends StatelessWidget {
   CSTabBar({
    @required this.itemList,
    Key key,
    this.color,
  }) : super(key: key);

  String itemList;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('dddddd $itemList, $color')
    );
  }
}
