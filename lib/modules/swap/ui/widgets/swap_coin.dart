part of swap_ui_module;

class SwapCoin extends HookWidget {
  const SwapCoin({
    @required this.fromCoin,
    @required this.toCoin,
    @required this.onChangeCoin,
    @required this.doChangeDirection,
    @required this.coinList,
  });

  final SwapConfigCoin fromCoin;
  final SwapConfigCoin toCoin;
  final List<MapEntry<SwapConfigCoin, SwapConfigCoin>> coinList;
  final Function(MapEntry<SwapConfigCoin, SwapConfigCoin>) onChangeCoin;
  final Function(MapEntry<SwapConfigCoin, SwapConfigCoin>) doChangeDirection;

  void showCoinSelectDialog(
    BuildContext context,
    SwapConfigCoin baseCoin,
    SwapConfigCoin selectCoin, {
    bool isSelectFrom,
  }) {
    final List<
            MapEntry<SwapConfigCoin, MapEntry<SwapConfigCoin, SwapConfigCoin>>>
        configList = [];
    final configIds = <String>{};

    for (final item in coinList) {
      final config = item.key.id == baseCoin.id
          ? item.value
          : item.value.id == baseCoin.id
              ? item.key
              : null;

      if (config != null && !configIds.contains(config.id)) {
        configIds.add(config.id);
        configList.add(MapEntry(config, item));
      }
    }

    final options = configList
        .map((e) => CSOptionsItem(
              label: e.key.name,
              value: e.value,
              color: e.key.id == selectCoin.id ? context.primaryColor : null,
            ))
        .toList();

    showOptionsDialog<MapEntry<SwapConfigCoin, SwapConfigCoin>>(
      context,
      options: options,
      onSelected: (value) {
        if (value.key.id != selectCoin.id) {
          onChangeCoin(isSelectFrom ? value : MapEntry(value.value, value.key));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final needReverse = useState(false);
    final angle = useState<double>(0);
    final rotateAnimation = useState<Animation<double>>(null);

    final iconSize = 20 + context.edgeSizeDouble;
    final itemWidth =
        (context.mediaWidth - context.edgeSizeDouble * 2 - iconSize) / 2;
    final xOffsetSize = (itemWidth + iconSize) / itemWidth;

    final controller =
        useAnimationController(duration: Duration(milliseconds: 300));
    final animations = useMemoized(() => <Animation<Offset>>[]);

    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        needReverse.value = false;
        doChangeDirection(MapEntry(toCoin, fromCoin));
      }
    }

    useEffect(() {
      needReverse.value = false;
      animations.clear();
      // left
      animations.add(Tween(
        begin: Offset.zero,
        end: Offset(xOffsetSize, 0),
      ).animate(controller));

      // right
      animations.add(Tween(
        begin: Offset.zero,
        end: Offset(-xOffsetSize, 0),
      ).animate(controller));

      // rotate
      rotateAnimation.value =
          Tween<double>(begin: 0.0, end: math.pi).animate(controller)
            ..addListener(() {
              angle.value = rotateAnimation.value.value;
            });

      controller.addStatusListener(listener);
      controller.reset();
      return () {
        controller.removeStatusListener(listener);
      };
    }, [fromCoin, toCoin]);

    return CSContainer(
      child: Stack(
        children: [
          Row(
            children: [
              SlideTransition(
                position: animations[0],
                child: buildItem(
                  context,
                  fromCoin,
                  itemWidth,
                  needReverse.value ? TextAlign.right : TextAlign.left,
                  0,
                ),
              ),
              SizedBox(
                width: iconSize,
                height: iconSize,
              ),
              SlideTransition(
                position: animations[1],
                child: buildItem(
                  context,
                  toCoin,
                  itemWidth,
                  needReverse.value ? TextAlign.left : TextAlign.right,
                  1,
                ),
              ),
            ],
          ),
          Center(
            child: Transform.rotate(
              angle: angle.value,
              child: CSButtonIcon(
                margin: EdgeInsets.all((iconSize - 28) / 2),
                size: 18,
                padding: EdgeInsets.zero,
                containerSize: 28,
                icon: CSIcons.Swap,
                borderRadius: 14,
                onPressed: () {
                  controller.forward();
                  needReverse.value = !needReverse.value;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    SwapConfigCoin coin,
    double itemWidth,
    TextAlign textAlign,
    int index,
  ) {
    return CSContainer(
      onTap: () {
        showCoinSelectDialog(
          context,
          index == 0 ? toCoin : fromCoin,
          index == 0 ? fromCoin : toCoin,
          isSelectFrom: index == 0,
        );
      },
      padding: context.edgeVertical,
      margin: EdgeInsets.zero,
      width: itemWidth,
      child: Text(
        coin?.name ?? '',
        style: context.textBody(bold: true),
        textAlign: textAlign,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
