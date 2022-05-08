part of trade_ui_module;

class HomeInputCard extends HookWidget {
  const HomeInputCard({
    @required this.tradeSide,
    @required this.tradePair,
    @required this.tradeCoinInfo,
    @required this.priceCoinInfo,
    @required this.sideCoinInfo,
    @required this.sideCoinConfig,
    @required this.updatePriceEvent,
    @required this.updateApproveEvent,
    @required this.onChangeSide,
    @required this.onSubmitOrder,
    @required this.onApproveOrder,
  });

  final TradeSide tradeSide;
  final TradePair tradePair;

  /// Coin to trade
  /// Example: for BTC/USDT it will be BTC
  final AssetCoin tradeCoinInfo;

  /// Coin Price Market to trade
  /// Example: for BTC/USDT it will be USDT
  final AssetCoin priceCoinInfo;

  /// Coin base on the side (Buy or Sell)
  /// Example: for Buy BTC/USDT it will be BTC
  final AssetCoin sideCoinInfo;

  final TradeConfigCoin sideCoinConfig;

  final Stream<String> updatePriceEvent;

  final Stream<double> updateApproveEvent;

  final Function(TradeSide) onChangeSide;

  /// Price and Amount
  final void Function({
    @required String price,
    @required String amount,
    @required String total,
  }) onSubmitOrder;

  /// Price and Amount
  final void Function({
    @required bool isReset,
  }) onApproveOrder;

  double getPriceAdjustment({
    @required String price,
    @required String amount,
    @required int dealPrecision,
  }) {
    var checkTotal = NumberUtil.multiply<double>(
      price,
      amount,
    );
    final needChangePrice =
        NumberUtil.getDecimalDigits(checkTotal) > dealPrecision;
    if (needChangePrice) {
      final increase = NumberUtil.getDecimalMinValue(
        NumberUtil.getDecimalDigits(price),
      );
      var newPrice = NumberUtil.getDouble(price);
      while (NumberUtil.getDecimalDigits(checkTotal) > dealPrecision) {
        newPrice = NumberUtil.plus<double>(
          newPrice,
          increase,
        );
        checkTotal = NumberUtil.multiply<double>(
          newPrice,
          amount,
        );
      }
      return newPrice;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isBuy = useState(tradeSide == TradeSide.buy);

    final fieldPrice = useTextEditingController(text: '');
    final fieldAmount = useTextEditingController(text: '');
    final fieldTotal = useTextEditingController(text: '');
    final maxChanges = useBehaviorStreamController<double>();
    final amountChanges = useBehaviorStreamController<double>();
    final payAmountChanges = useBehaviorStreamController<double>();
    final ratioChanges = useStreamController<String>();
    final totalChanges = useStreamController<String>();
    final priceFiatValue = useStreamController<String>();
    final dealPrecision = sideCoinConfig?.dealPrecision ?? 6;
    final approveBalance = useStream(updateApproveEvent);
    final tickersCubit = BlocProvider.of<TradeTickersCubit>(context);

    final hasWallet = priceCoinInfo != null &&
        sideCoinConfig != null &&
        tradeCoinInfo != null;

    final isChainNeedApprove =
        hasWallet && tradePair.isChainNeedApprove(tradeSide);

    void updateTotal() {
      if (fieldAmount.text.isNotEmpty && fieldPrice.text.isNotEmpty) {
        final total = NumberUtil.multiply<String>(
              fieldPrice.text,
              fieldAmount.text,
              dealPrecision,
            ) ??
            '-';
        fieldTotal.text = total;
        totalChanges.add(total);
      } else {
        fieldTotal.text = '-';
        totalChanges.add('-');
      }

      if (isChainNeedApprove) {
        final payAmount = NumberUtil.getDouble(
          isBuy.value ? fieldTotal.text : fieldAmount.text,
        );
        payAmountChanges.add(payAmount);
      }
    }

    void updatePriceFiatValue() {
      final fiatPriceCubit = GetIt.I<FiatPriceCubit>();
      final coinPriceCubit = GetIt.I<CoinPriceCubit>();

      final price = fiatPriceCubit.state.getFiatPrice(
        coinPrice: coinPriceCubit.state.getCoinPrice(
          tradePairId: tradePair.id,
        ),
        amount: NumberUtil.getDouble(fieldPrice.text),
      );
      priceFiatValue.add(price);
    }

    void updateWithLastPrice() {
      if (isBuy.value) {
        fieldPrice.text = tickersCubit.latestSellPrice;
      } else {
        fieldPrice.text = tickersCubit.latestBuyPrice;
      }
      updatePriceFiatValue();
    }

    void updateMaxBuySell() {
      if (!hasWallet) {
        return;
      }
      if (isBuy.value) {
        if (fieldPrice.text.isNotEmpty) {
          final price = NumberUtil.getDouble(fieldPrice.text);
          final maxAmount = NumberUtil.divide<double>(
            NumberUtil.minus<double>(
              priceCoinInfo.balance,
              sideCoinConfig.inputNetworkFee ?? 0,
            ),
            price,
            sideCoinConfig.dealPrecision ?? 6,
          );
          maxChanges.add(maxAmount > 0 ? maxAmount : 0);
        } else {
          maxChanges.add(0);
        }
      } else {
        final maxAmount = NumberUtil.minus<double>(
          tradeCoinInfo.balance,
          sideCoinConfig.inputNetworkFee ?? 0,
        );
        maxChanges.add(maxAmount > 0 ? maxAmount : 0);
      }
    }

    void clearInput() {
      // Reset amount and prices
      fieldPrice.text = '';
      fieldAmount.text = '';
      amountChanges.add(0);
      ratioChanges.add('0');
      maxChanges.add(0);
      updatePriceFiatValue();
    }

    useEffect(() {
      clearInput();
      updateMaxBuySell();
      updateTotal();
      return null;
    }, [tradePair.id]);

    useEffect(() {
      updateMaxBuySell();
      return null;
    }, [tradeCoinInfo?.balance, priceCoinInfo?.balance]);

    useEffect(() {
      isBuy.value = tradeSide == TradeSide.buy;
      clearInput();
      updateWithLastPrice();
      updateMaxBuySell();
      updateTotal();
      return null;
    }, [tradeSide]);

    useEffect(() {
      final subInitialPrice = tickersCubit.listen((data) {
        if (fieldPrice.text.isEmpty) {
          updateWithLastPrice();
          updateMaxBuySell();
        }
      });
      final subUpdatePrice = updatePriceEvent.listen((data) {
        fieldPrice.text = data;
        updateMaxBuySell();
        updatePriceFiatValue();
        updateTotal();
      });
      final subUpdateApprove = updateApproveEvent.listen((data) {
        updateTotal();
      });
      return () {
        subInitialPrice.cancel();
        subUpdatePrice.cancel();
        subUpdateApprove.cancel();
      };
    }, []);

    return CSContainer(
      margin: context.edgeAll.copyWith(left: 0, top: 6, bottom: 6),
      padding: context.edgeVertical,
      child: Column(
        children: [
          CSButtonGroup(
            selectedId: tradeSide.index,
            onSelectedId: (value) {
              final direction =
                  value == TradeSide.buy.index ? TradeSide.buy : TradeSide.sell;
              if (direction != tradeSide) {
                onChangeSide(direction);
              }
            },
          ),
          SizedBox(height: context.edgeSize),
          Padding(
            padding: context.edgeHorizontal8,
            child: Column(
              children: [
                CSAmountInput(
                  step: NumberUtil.getDecimalMinValue(dealPrecision),
                  controller: fieldPrice,
                  maxInteger: 8,
                  maxDecimal: dealPrecision,
                  hintText: tr('trade:order_hint_price'),
                  hintStyle: context.textSecondary(bold: true),
                  onChanged: (price) {
                    updateMaxBuySell();
                    updateTotal();
                    updatePriceFiatValue();
                  },
                ),
                SizedBox(height: 6),
                AssetPriceListener(
                  key: ValueKey(tradePair.id),
                  tradePairId: tradePair.id,
                  builder: (context, fiatPrice, fiatCurrency, data) =>
                      StreamBuilder<String>(
                    stream: priceFiatValue.stream,
                    initialData: '-',
                    builder: (context, snapshot) => RowItemBar(
                      tr('trade:order_lbl_fiat_price'),
                      '≈ ${snapshot.data} $fiatCurrency',
                      valueStyle: context.textSmall(),
                      textStyle: context.textSmall(),
                    ),
                  ),
                ),
                SizedBox(height: context.edgeSize),
                AssetBalanceListener(
                  key: ValueKey(sideCoinInfo?.symbol),
                  item: sideCoinInfo,
                  builder: (context, {balance, unconfirmed, data}) => Column(
                    children: [
                      CSAmountInput(
                        controller: fieldAmount,
                        maxInteger: 8,
                        maxDecimal: dealPrecision,
                        hintText: tr('trade:order_hint_amount'),
                        unit: tradeCoinInfo?.symbol ?? '',
                        spinner: false,
                        hintStyle: context.textSecondary(bold: true),
                        onChanged: (value) {
                          if (data.balance <= 0) {
                            Toast.show(tr('asset:withdraw_msg_error_balance'));
                          }
                          amountChanges.add(NumberUtil.getDouble(value));
                          updateTotal();
                          ratioChanges.add('0');
                        },
                      ),
                      SizedBox(height: 6),
                      RowItemBar(
                        tr('trade:order_lbl_available'),
                        '''$balance ${sideCoinInfo?.symbol ?? ''}''',
                        key: Key(balance),
                        valueFlex: 2,
                        textStyle: context.textSmall(),
                        valueStyle: context.textSmall(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                CSAmountSelect(
                  maxChanges: maxChanges.stream,
                  ratioChanges: ratioChanges.stream,
                  selectedSide: tradeSide.index,
                  onChanged: (value, ratio) {
                    fieldAmount.text = NumberUtil.truncateDecimal<String>(
                      value,
                      dealPrecision,
                    );
                    ratioChanges.add(ratio);
                    updateTotal();
                  },
                ),
                SizedBox(height: 10),
                Divider(height: 0.5, color: context.greyColor),
                SizedBox(height: 10),
                if (sideCoinConfig != null &&
                    sideCoinConfig.inputNetworkFee > 0)
                  RowItemBar(
                    tr('trade:order_lbl_miner_fee_order'),
                    '''${sideCoinConfig.networkFee ?? '-'} ${sideCoinConfig.symbol ?? ''}''',
                    valueStyle: context.textSmall(),
                    textStyle: context.textSmall(),
                  ),
                if (isChainNeedApprove)
                  RowItemBar(
                    tr('trade:order_lbl_approve_balance'),
                    '',
                    textStyle: context.textSmall(),
                    valueWidget: CSButton(
                      flat: true,
                      padding: EdgeInsets.zero,
                      alignment: MainAxisAlignment.end,
                      label:
                          '''${approveBalance.data ?? '-'} ${sideCoinInfo.symbol ?? ''}''',
                      textStyle: context
                          .textSmall(color: context.bodyColor, bold: true)
                          .copyWith(decoration: TextDecoration.underline),
                      onPressed: () {
                        if (NumberUtil.getDouble(approveBalance.data) <= 0) {
                          Toast.show(
                            tr('trade:order_msg_error_approve_balance_zero'),
                          );
                          return;
                        }
                        showConfirmDialog(
                          context,
                          content: tr('trade:order_msg_approve_reset_confirm'),
                          onConfirm: () {
                            onApproveOrder(isReset: true);
                          },
                        );
                      },
                    ),
                  ),
                if (isChainNeedApprove) SizedBox(height: 10),
                if (sideCoinConfig != null &&
                    sideCoinConfig.inputNetworkFee > 0)
                  SizedBox(height: 10),
                StreamBuilder<String>(
                  stream: totalChanges.stream,
                  initialData: '-',
                  builder: (context, snapshot) => RowItemBar(
                    tr('trade:order_lbl_total'),
                    '${snapshot.data} ${priceCoinInfo?.symbol ?? ''}',
                    valueStyle: context.textSmall(
                      color: context.bodyColor,
                      bold: true,
                    ),
                    textStyle: context.textSmall(),
                    valueFlex: 2,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          StreamBuilder<double>(
            initialData: 0.0,
            stream: payAmountChanges.stream,
            builder: (context, snapshot) {
              final buttonColor =
                  isBuy.value ? context.greenColor : context.redColor;
              final needApprove = isChainNeedApprove &&
                  NumberUtil.isGreater(snapshot.data, approveBalance.data);
              return CSButton(
                label: hasWallet
                    ? needApprove
                        ? tr('trade:order_btn_approve')
                        : tr(
                            'trade:order_btn_${isBuy.value ? 'buy' : 'sell'}',
                            namedArgs: {'symbol': tradeCoinInfo?.symbol ?? ''},
                          )
                    : tr('trade:order_btn_create_wallet'),
                textColor: needApprove ? buttonColor : context.whiteColor,
                margin: context.edgeHorizontal8,
                backgroundColor: needApprove ? context.whiteColor : buttonColor,
                borderColor: needApprove ? buttonColor : Colors.transparent,
                bordered: needApprove,
                onPressed: () {
                  if (FocusManager.instance.primaryFocus.hasPrimaryFocus) {
                    FocusManager.instance.primaryFocus.unfocus();
                  }
                  if (!hasWallet) {
                    AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
                    Toast.show(tr('wallet:msg_create_wallet_need'));
                    return;
                  }
                  final payAmount = NumberUtil.getDouble(
                    isBuy.value ? fieldTotal.text : fieldAmount.text,
                  );
                  // Check balance
                  if (!NumberUtil.isGreater(fieldPrice.text, 0)) {
                    Toast.show(tr('trade:order_msg_error_price_empty'));
                    return;
                  }
                  if (!NumberUtil.isGreater(fieldAmount.text, 0)) {
                    Toast.show(tr('trade:order_msg_error_amount_empty'));
                    return;
                  }
                  if (sideCoinConfig == null) {
                    Toast.show(tr('trade:order_msg_error_not_config'));
                    return;
                  }
                  if (NumberUtil.isGreater(payAmount, sideCoinInfo.balance)) {
                    Toast.show(tr('trade:order_msg_error_amount_not_enough'));
                    return;
                  }
                  if (NumberUtil.isGreater(
                    payAmount,
                    sideCoinConfig.maxAmount,
                  )) {
                    Toast.show(tr(
                      'trade:order_msg_error_amount_too_high',
                      namedArgs: {
                        'amount': sideCoinConfig.maxAmount.toString(),
                        'symbol': sideCoinConfig.symbol,
                      },
                    ));
                    return;
                  }
                  if (NumberUtil.isLessOrEqual(
                    payAmount,
                    sideCoinConfig.minAmount,
                  )) {
                    Toast.show(tr(
                      'trade:order_msg_error_amount_too_low',
                      namedArgs: {
                        'amount': sideCoinConfig.minAmount.toString(),
                        'symbol': sideCoinConfig.symbol,
                      },
                    ));
                    return;
                  }
                  if (needApprove) {
                    if (approveBalance.data == null) {
                      Toast.show(
                        tr('trade:order_msg_error_approve_balance_empty'),
                      );
                      return;
                    }
                    onApproveOrder(
                      isReset: false,
                    );
                  } else {
                    if (isChainNeedApprove) {
                      final newPrice = getPriceAdjustment(
                        price: fieldPrice.text,
                        amount: fieldAmount.text,
                        dealPrecision: dealPrecision,
                      );
                      if (newPrice != null) {
                        AnalyticsReport().reportLog('Trade_AlertChangePrice', {
                          'price': fieldPrice.text,
                          'amount': fieldAmount.text,
                          'newPrice': newPrice,
                        });
                        showAlertDialog(
                          context,
                          content: tr(
                            'trade:order_msg_error_price_round',
                            namedArgs: {
                              'price': newPrice.toString(),
                            },
                          ),
                        );
                        return;
                      }
                    }
                    onSubmitOrder(
                      price: fieldPrice.text,
                      amount: fieldAmount.text,
                      total: fieldTotal.text,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
