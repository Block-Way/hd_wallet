// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AdmissionCondition.serializer)
      ..add(AdmissionConfig.serializer)
      ..add(AdmissionInfo.serializer)
      ..add(AssetAddress.serializer)
      ..add(AssetCoin.serializer)
      ..add(AssetPrice.serializer)
      ..add(CommunityConfig.serializer)
      ..add(CommunityEcological.serializer)
      ..add(CommunityInfo.serializer)
      ..add(CommunityMember.serializer)
      ..add(CommunityMemberInfo.serializer)
      ..add(CommunityTeam.serializer)
      ..add(CommunityTeamOptions.serializer)
      ..add(Config.serializer)
      ..add(ConfigCoin.serializer)
      ..add(ConfigCoinFee.serializer)
      ..add(ConfigOtc.serializer)
      ..add(ConfigSystem.serializer)
      ..add(ConfigSystemApp.serializer)
      ..add(ConfigUpdate.serializer)
      ..add(ConfigUpdateData.serializer)
      ..add(HomeBanner.serializer)
      ..add(InvestConfig.serializer)
      ..add(MintChart.serializer)
      ..add(MintInfo.serializer)
      ..add(MintItem.serializer)
      ..add(NoticeInfo.serializer)
      ..add(ProfitInvitationItem.serializer)
      ..add(ProfitRecordItem.serializer)
      ..add(ProjectConfig.serializer)
      ..add(ProjectCreateMint.serializer)
      ..add(ProjectCreateParams.serializer)
      ..add(ProjectInfo.serializer)
      ..add(SettingsConfig.serializer)
      ..add(SwapConfig.serializer)
      ..add(SwapConfigCoin.serializer)
      ..add(TradeConfig.serializer)
      ..add(TradeConfigCoin.serializer)
      ..add(TradeConfigPair.serializer)
      ..add(TradeConfigPairItem.serializer)
      ..add(TradeConfigPairItemInfo.serializer)
      ..add(TradeDeal.serializer)
      ..add(TradeInfo24h.serializer)
      ..add(TradeMarket.serializer)
      ..add(TradeOrderDetail.serializer)
      ..add(TradeOrderDetailItem.serializer)
      ..add(TradePair.serializer)
      ..add(TradeTicker.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AdmissionCondition)]),
          () => new ListBuilder<AdmissionCondition>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(SwapConfigCoin)])
          ]),
          () => new ListBuilder<BuiltList<SwapConfigCoin>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MintItem)]),
          () => new ListBuilder<MintItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MintItem)]),
          () => new ListBuilder<MintItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProjectCreateMint)]),
          () => new ListBuilder<ProjectCreateMint>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TradeConfigCoin)]),
          () => new ListBuilder<TradeConfigCoin>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(String), const FullType(TradeConfigPair)]),
          () => new MapBuilder<String, TradeConfigPair>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(TradeOrderDetailItem)]),
          () => new ListBuilder<TradeOrderDetailItem>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(TradeOrderDetailItem)]),
          () => new ListBuilder<TradeOrderDetailItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AdmissionInfo)]),
          () => new ListBuilder<AdmissionInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CommunityInfo)]),
          () => new ListBuilder<CommunityInfo>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(CommunityEcological)]),
          () => new ListBuilder<CommunityEcological>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(String)])
          ]),
          () => new MapBuilder<String, BuiltList<String>>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])
          ]),
          () => new MapBuilder<String, BuiltMap<String, String>>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(String), const FullType(ConfigCoin)]),
          () => new MapBuilder<String, ConfigCoin>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(String), const FullType(ConfigSystemApp)]),
          () => new MapBuilder<String, ConfigSystemApp>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(TradeConfigPairItem)]),
          () => new ListBuilder<TradeConfigPairItem>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(double)]),
          () => new MapBuilder<String, double>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
