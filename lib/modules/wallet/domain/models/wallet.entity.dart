part of wallet_domain_module;

const kWalletNameMaxLength = 30;

/// Wallet status
@HiveType(typeId: kHiveTypeWalletStatus)
enum WalletStatus {
  @HiveField(0)
  synced,

  @HiveField(1)
  notSynced,

  @HiveField(2)
  unknown,

  @HiveField(3)
  loading,
}

/// Type of this wallet (used to generate address)
@HiveType(typeId: kHiveTypeWalletType)
enum WalletType {
  /// 路径BIP44，兼容imToken钱包助记词导入
  @HiveField(0)
  mnemonicBip44,

  /// 路径BIP39，兼容PockMine钱包助记词导入
  @HiveField(1)
  mnemonicBip39,

  /// Only privateKey wallet
  @HiveField(2)
  privateKey,

  /// Device wallet
  @HiveField(3)
  device,
}

@HiveType(typeId: kHiveTypeWallet)
class Wallet extends HiveObject {
  Wallet({
    @required this.id,
    @required this.type,
    @required this.name,
    @required this.addresses,
    @required this.hasBackup,
    @required this.coins,
  }) {
    balances = [];
    createdAt = DateTime.now();
    status = WalletStatus.notSynced;
  }

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  WalletType type;
  @HiveField(3)
  WalletStatus status;
  @HiveField(4)
  bool hasBackup;

  @HiveField(5)
  DateTime createdAt;
  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  List<CoinInfo> coins;
  @HiveField(8)
  List<CoinBalance> balances;
  @HiveField(9)
  List<CoinAddress> addresses;

  // Flags

  /// If true this is device wallet
  bool get isDevice => type == WalletType.device;

  List<String> get supportedChains => addresses.map((e) => e.chain).toList();

  String get bbcAddress {
    final coin = addresses?.firstWhere(
      (item) => item.chain == 'BBC',
      orElse: () => null,
    );
    if (coin?.address != null && coin.address.isNotEmpty) {
      return StringUtils.strCut(
        coin.address,
        startKeep: 6,
        endKeep: 6,
      );
    }
    return '';
  }

  bool isCoinBalanceLocked({
    @required String chain,
    @required String symbol,
    @required String address,
  }) {
    assert(chain != null, symbol != null);
    assert(address != null);
    if (!isThisWalletAddress(address)) {
      return false;
    }
    final data = balances?.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    return data?.lockUntil?.isAfter(DateTime.now()) ?? false;
  }

  bool isThisWalletAddress(String address) {
    assert(address != null);
    return addresses.where((element) => element.address == address).isNotEmpty;
  }

  String getTotalValuation(String fiatCurrency) {
    final fiatPriceCubit = GetIt.I<FiatPriceCubit>();
    final coinPriceCubit = GetIt.I<CoinPriceCubit>();

    final total = balances
        .where((coin) => coin.balance > 0)
        .map((balance) => fiatPriceCubit.state.getFiatPrice(
              coinPrice: coinPriceCubit.state.getCoinPrice(
                tradePairId: '${balance.symbol}/USDT',
              ),
              amount: balance.balance,
            ))
        .fold<double>(
          0.0,
          (prev, cur) => prev + NumberUtil.getDouble(cur),
        );
    return NumberUtil.truncateDecimal(total ?? 0, AppConstants.fiatPrecision);
  }

  /// Get coin balance from this wallet cache
  double getCoinBalance({
    @required String chain,
    @required String symbol,
  }) {
    assert(chain != null, symbol != null);
    final data = balances?.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    return data == null ? 0 : data.balance ?? 0;
  }

  /// Get Unconfirmed coin balance
  /// (balance that is incoming but not confirmed yet)
  double getCoinBalanceUnconfirmed({
    @required String chain,
    @required String symbol,
  }) {
    assert(chain != null, symbol != null);
    final data = balances?.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    return data == null ? 0 : data.unconfirmed ?? 0;
  }

  CoinBalance getCoinBalanceInfo({
    @required String address,
    @required String chain,
    @required String symbol,
  }) {
    assert(chain != null, symbol != null);
    if (!isThisWalletAddress(address)) {
      return null;
    }
    final data = balances?.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    return data;
  }

  /// Update coin enable to use state
  void updateCoinEnable({
    @required String chain,
    @required String symbol,
    @required bool isEnabled,
  }) {
    assert(chain != null, symbol != null);
    assert(isEnabled != null);
    final coinInfo = coins.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    if (coinInfo != null) {
      coinInfo.isEnabled = isEnabled;
      save();
    }
  }

  /// Update coin balance in this wallet
  void updateCoinBalance({
    @required String chain,
    @required String symbol,
    @required String address,
    @required double balance,
    @required double unconfirmed,
  }) {
    assert(chain != null, symbol != null);
    assert(address != null);
    // Check if this address is in this wallet
    if (!isThisWalletAddress(address)) {
      return;
    }

    // Old version remove coin without chain
    balances.removeWhere((e) => e.symbol == symbol && e.chain == null);

    final coinBalance = balances.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () {
        final coinBalance = CoinBalance(chain: chain, symbol: symbol);
        balances.add(coinBalance);
        return coinBalance;
      },
    );
    if (coinBalance != null) {
      coinBalance.balance = balance;
      coinBalance.unconfirmed = unconfirmed;
      coinBalance.updatedAt = DateTime.now();
      save();
    }
  }

  /// Forbid Update balance until the given time
  void lockUpdateCoinBalance({
    @required String chain,
    @required String symbol,
    @required String address,
    @required DateTime lookUntil,
  }) {
    assert(chain != null, symbol != null);
    assert(address != null);
    if (!isThisWalletAddress(address)) {
      return;
    }
    final coinBalance = balances.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
    if (coinBalance != null) {
      coinBalance.lockUntil = lookUntil;
      save();
    }
  }

  /// Add or update a specific chain address in this wallet
  void updateCoinAddress({
    @required String chain,
    @required String address,
    @required String publicKey,
  }) {
    assert(chain != null, address != null);
    addresses.removeWhere((element) => element.chain == chain);
    addresses.add(CoinAddress(
      chain: chain,
      symbol: chain,
      address: address,
      publicKey: publicKey,
    ));
    updatedAt = DateTime.now();
    save();
  }

  void updateStatus({
    @required WalletStatus status,
  }) {
    this.status = status;
    updatedAt = DateTime.now();
    save();
  }

  String getCoinAddressByChain(String chain) {
    assert(chain != null);
    return addresses
            ?.firstWhere(
              (e) => e.chain == chain,
              orElse: () => null,
            )
            ?.address ??
        '';
  }

  @override
  String toString() => '$id-$name';
}
