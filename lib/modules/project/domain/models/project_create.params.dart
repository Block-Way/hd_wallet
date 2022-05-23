part of project_domain_module;

final kDefaultMintList = [
  ProjectCreateMint(
    month: '',
    ratio: '',
    index: 1,
  ),
];

abstract class ProjectCreateParams
    implements Built<ProjectCreateParams, ProjectCreateParamsBuilder> {
  // Constructors

  factory ProjectCreateParams() {
    return _$ProjectCreateParams._(
      projectName: '',
      projectDescription: '',
      coinName: '',
      price: '',
      amount: '',
      issuerName: '',
      webUrl: '',
      email: '',
      poolMinCurrency: '',
      poolCycle: '',
      poolInitAmount: '',
      poolEnable: false,
      remainPoolMonths: '',
      remainPoolAmount: '',
      minBalance: '',
      mintList: BuiltList(kDefaultMintList),
    );
  }
  ProjectCreateParams._();

  static Serializer<ProjectCreateParams> get serializer =>
      _$projectCreateParamsSerializer;

  static ProjectCreateParams fromJson(dynamic json) {
    if (json != null) {
      return deserialize<ProjectCreateParams>(json);
    }
    return null;
  }

  Object toJson() {
    return serialize<ProjectCreateParams>(this);
  }

// Fields
  String get projectName;
  String get projectDescription;
  String get coinName;
  String get price;
  String get amount;

  String get issuerName;
  String get webUrl;
  String get email;

  String get poolMinCurrency;
  String get poolCycle;
  String get poolInitAmount;
  bool get poolEnable;

  String get remainPoolMonths;
  String get remainPoolAmount;
  String get minBalance;

  BuiltList<ProjectCreateMint> get mintList;

// TODO： Withdraw Info

  @nullable
  String get chain;
  @nullable
  String get symbol;
  @nullable
  String get txId;
  @nullable
  String get address;
  @nullable
  @BuiltValueSerializer(custom: true)
  WalletWithdrawData get withdrawData;
  @nullable
  double get withdrawAmount;
  @nullable
  int get submittedAt;

  Map<String, dynamic> toApiParams() {
    return {
      // 'mortgage_tx': txId,
      // 'owner_address': address,
      'owner_name': issuerName,
      'owner_website': webUrl,
      'owner_email': email,
      'project_name': projectName,
      'project_description': projectDescription,
      'currency': coinName?.toUpperCase(),
      'currency_price': price,
      'currency_issuing_amount': amount,
      'currency_issuing_initial_amount': poolInitAmount,
      'currency_issuing_cycle': poolCycle,
      // 10 关闭 11 开启
      'mint_enable': poolStatus,
      'mint_config': {
        'minBalance': minBalance,
        'remainPoolMonths': remainPoolMonths,
        'remainPoolAmount': remainPoolAmount,
        'poolConfig': _validMintList.map((config) {
          return {
            'month': config.month,
            'ratio': config.ratio,
          };
        }).toList(),
      },
    };
  }

  ProjectCreateParams setPool({
    @required String poolInitAmount,
    @required String poolCycle,
    @required String poolMinCurrency,
    @required bool poolEnable,
    @required String minBalance,
    @required String remainAmount,
    @required String remainMonths,
    @required List<ProjectCreateMint> mintList,
  }) {
    return rebuild(
      (a) => a
        ..poolInitAmount = poolInitAmount
        ..poolCycle = poolCycle
        ..poolMinCurrency = poolMinCurrency
        ..poolEnable = poolEnable
        ..remainPoolAmount = remainAmount
        ..remainPoolMonths = remainMonths
        ..mintList = ListBuilder(mintList)
        ..minBalance = minBalance,
    );
  }

  int get poolStatus => poolEnable == true ? 11 : 10;

  List<ProjectCreateMint> cacheMintConfig(
    List<ProjectCreateMint> mintList,
  ) {
    if (mintList.length > 1) {
      mintList.retainWhere((item) => item.month != '' || item.ratio != '');
    }
    return mintList;
  }

  List<ProjectCreateMint> removeMintConfig(
    List<ProjectCreateMint> mintList,
    int index,
  ) {
    final List<ProjectCreateMint> list = [];
    mintList.asMap().entries.map((entry) {
      if (entry.key != index) {
        list.add(entry.value);
      }
    }).toList();
    return list;
  }

  List<ProjectCreateMint> updateMintConfig(
    List<ProjectCreateMint> mintList,
    int index, {
    String month,
    String ratio,
  }) {
    return mintList.asMap().entries.map((item) {
      if (item.key == index) {
        return item.value.rebuild((a) => a
          ..month = month ?? a.month
          ..ratio = ratio ?? a.ratio);
      }
      return item.value;
    }).toList();
  }

  List<ProjectCreateMint> get _validMintList =>
      mintList.where((item) => item.ratio != '' && item.month != '').toList();

  int getMintRemainMonths(
    List<ProjectCreateMint> list,
    String poolCycle,
  ) {
    final totalMonths = list.map((e) => e.month).toList().reduce(
          (cur, next) => NumberUtil.plus(
            NumberUtil.getDouble(cur) ?? 0,
            NumberUtil.getDouble(next) ?? 0,
          ),
        );
    return NumberUtil.minus<int>(
          poolCycle,
          totalMonths ?? 0,
        ) ??
        0;
  }

  String getMintRemainAmount(
    List<ProjectCreateMint> list,
    String poolInitAmount,
  ) {
    double mintTotalAmount;

    for (final item in list) {
      if (item.ratio != '' && item.month != '') {
        final ratio = math.pow(
          NumberUtil.plus<double>(1, NumberUtil.divide(item.ratio, 100)),
          NumberUtil.getDouble(item.month),
        );
        mintTotalAmount = NumberUtil.multiply(ratio, mintTotalAmount ?? 1);
      }
    }
    return NumberUtil.truncateDecimal(
            NumberUtil.minus(
                amount,
                NumberUtil.multiply(
                  poolInitAmount ?? 0,
                  mintTotalAmount,
                )),
            2) ??
        '0.00';
  }
}
