part of trade_ui_module;

class TradeMainTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelPermissionView(
      moduleName: ModuleName.trade,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TradeTickersCubit>(
            create: (context) => TradeTickersCubit(),
          ),
        ],
        child: TradeHomePage(),
      ),
    );
  }
}
