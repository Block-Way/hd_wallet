part of wallet_domain_module;

class WalletFeeUtils {
  static List<MapEntry<String, String>> getFeeOptions({
    @required String chain,
    @required ConfigCoinFee configCoinFee,
    @required WalletWithdrawFeeData defaultFee,
  }) {
    final List<MapEntry<String, String>> feeOptions = [];
    switch (chain) {
      case 'BTC':
        configCoinFee.level.forEach(
          (level, ratio) {
            final satoshi = NumberUtil.multiply<int>(
              defaultFee.feeRate,
              ratio == 0 ? 1 : ratio,
            );
            feeOptions.add(MapEntry(level, getBTCFeeRate(satoshi)));
          },
        );
        break;
      case 'ETH':
        configCoinFee.level.forEach(
          (level, ratio) {
            final gasPrice = NumberUtil.multiply<int>(
              defaultFee.gasPrice,
              ratio == 0 ? 1 : ratio,
            );
            feeOptions.add(MapEntry(level, getETHFeeRate(gasPrice)));
          },
        );
        break;
      case 'TRX':
        configCoinFee.level.forEach((level, ratio) {
          final sun = NumberUtil.multiply<int>(
            defaultFee.feeRate,
            ratio == 0 ? 1 : ratio,
          );
          feeOptions.add(MapEntry(level, getTRXFeeRate(sun)));
        });
        break;
      case 'BBC':
        configCoinFee.level.forEach(
          (level, ratio) {
            final bbc = NumberUtil.multiply<double>(
              defaultFee.feeRate,
              ratio == 0 ? 1 : ratio,
            );
            feeOptions.add(MapEntry(level, getBBCFeeRate(bbc)));
          },
        );
        break;
      default:
        break;
    }
    feeOptions.sort(
      (a, b) => NumberUtil.getDouble(b.value).compareTo(
        NumberUtil.getDouble(a.value),
      ),
    );
    return feeOptions;
  }

  /// Return fee in gwei
  static String getETHFeeRate(int gasPrice) {
    return NumberUtil.getIntAmountAsDouble(gasPrice, 9).toStringAsFixed(0);
  }

  /// Return fee in ETH
  static double getETHFeeValue({
    @required int gasPrice,
    @required int gasLimit,
    @required int chainPrecision,
  }) {
    final fee = NumberUtil.getIntAmountAsDouble(
      gasPrice * gasLimit,
    );
    return NumberUtil.truncateDecimal<double>(fee, chainPrecision);
  }

  /// Return fee in SUN
  static String getTRXFeeRate(int sun) {
    return sun.toStringAsFixed(0);
  }

  /// Return fee in TRX
  static double getTRXFeeValue({
    @required int sun,
    @required int chainPrecision,
  }) {
    return NumberUtil.truncateDecimal<double>(
      NumberUtil.getIntAmountAsDouble(sun, 6),
      chainPrecision,
    );
  }

  /// Return fee in BBC
  static String getBBCFeeRate(double bbc) {
    return NumberUtil.truncateDecimal<String>(
      bbc,
      10,
    );
  }

  /// Return fee in BBC
  static double getBBCFeeValue({
    @required double bbc,
    @required int chainPrecision,
  }) {
    return NumberUtil.truncateDecimal<double>(
      bbc,
      chainPrecision,
    );
  }

  /// Return fee in Satoshi/byte
  static String getBTCFeeRate(int satoshi) {
    return satoshi.toStringAsFixed(0);
  }

  /// Return fee in BTC (Bitcoin)
  static Future<double> getBTCFeeValue({
    @required int satoshi,
    @required String fromAddress,
  }) async {
    try {
      final unspent = await WalletRepository().getUnspentFromCache(
        symbol: 'BTC',
        address: fromAddress,
      );
      if (unspent == null || unspent.isEmpty) {
        return null;
      }
      final utxos = unspent
          .map((item) => {
                'txId': item['tx_hash'],
                'vOut': NumberUtil.getInt(item['tx_output_n']),
                'vAmount': Decimal.parse('${item['value']}').toInt(),
              })
          .toList();
      final feeInBtc = await WalletRepository().createBTCTransaction(
        utxos: utxos,
        toAddress: fromAddress,
        fromAddress: fromAddress,
        toAmount: 0,
        feeRate: satoshi,
        beta: WalletConfigNetwork.btc,
        isGetFee: true,
      );
      return NumberUtil.truncateDecimal<double>(
        feeInBtc,
        8,
      );
    } catch (error) {
      return 0.0;
    }
  }

  static Future<WalletWithdrawFeeData> getFeeData({
    @required WalletWithdrawFeeData defaultFee,
    @required AssetCoin coinInfo,
    @required String level,
    @required String fromAddress,
  }) async {
    final configCoinFee = GetIt.I<CoinConfig>().getFeeLevel(
      chain: coinInfo.chain,
      symbol: coinInfo.symbol,
    );
    final ratio =
        configCoinFee.level[level] == 0 ? 1.0 : configCoinFee.level[level];

    switch (coinInfo.chain) {
      case 'BTC':
        final satoshi = NumberUtil.multiply<int>(defaultFee.feeRate, ratio);
        final feeValue = await getBTCFeeValue(
          satoshi: satoshi,
          fromAddress: fromAddress,
        );
        final feeRate = getBTCFeeRate(satoshi);
        return defaultFee.copyWith(
          feeLevel: level,
          feeValue: feeValue,
          feeRate: feeRate,
        );
      case 'ETH':
        final gasPrice = NumberUtil.multiply<int>(defaultFee.gasPrice, ratio);
        final feeValue = getETHFeeValue(
          gasPrice: gasPrice,
          gasLimit: defaultFee.gasLimit,
          chainPrecision: coinInfo.chainPrecision,
        );
        final feeRate = getETHFeeRate(gasPrice);
        return defaultFee.copyWith(
          gasPrice: gasPrice,
          feeLevel: level,
          feeValue: feeValue,
          feeRate: feeRate,
        );
      case 'TRX':
        final sun = NumberUtil.multiply<int>(defaultFee.feeRate, ratio);
        final feeValue = getTRXFeeValue(
          sun: sun,
          chainPrecision: coinInfo.chainPrecision,
        );
        final feeRate = getTRXFeeRate(sun);
        return defaultFee.copyWith(
          feeLevel: level,
          feeValue: feeValue,
          feeRate: feeRate,
        );
      case 'BBC':
        final bbc = NumberUtil.multiply<double>(defaultFee.feeRate, ratio);
        final feeValue = getBBCFeeValue(
          bbc: bbc,
          chainPrecision: coinInfo.chainPrecision,
        );
        final feeRate = getBBCFeeRate(bbc);
        return defaultFee.copyWith(
          feeLevel: level,
          feeValue: feeValue,
          feeRate: feeRate,
        );
      default:
        return null;
    }
  }
}
