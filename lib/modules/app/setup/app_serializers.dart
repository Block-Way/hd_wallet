library serializers;

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

// Project imports:
import 'package:sugar/modules/admission/domain/admission.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/community/domain/community.dart';
import 'package:sugar/modules/home/domain/home.dart';
import 'package:sugar/modules/invest/domain/invest.dart';
import 'package:sugar/modules/notice/domain/notice.dart';
import 'package:sugar/modules/project/domain/project.dart';
import 'package:sugar/modules/settings/domain/settings.dart';
import 'package:sugar/modules/swap/domain/swap.dart';
import 'package:sugar/modules/trade/domain/trade.dart';

part 'app_serializers.g.dart';

/// Example of how to use built_value serialization.
///
/// Declare a top level [Serializers] field called serializers. Annotate it
/// with [SerializersFor] and provide a `const` `List` of types you want to
/// be serialize.
///
/// The built_value code generator will provide the implementation. It will
/// contain serializers for all the types asked for explicitly plus all the
/// types needed transitively via fields.
///
/// You usually only need to do this once per project.
@SerializersFor([
  ...kModuleCommonSerializeModels,
  ...kModuleAssetSerializeModels,
  ...kModuleHomeSerializeModels,
  ...kModuleNoticeSerializeModels,
  ...kModuleTradeSerializeModels,
  ...kModuleSettingsSerializeModels,
  ...kModuleCommunitySerializeModels,
  ...kModuleInvestSerializeModels,
  ...kModuleAdmissionSerializeModels,
  ...kModuleSwapSerializeModels,
  ...kModuleProjectSerializeModels,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();

final Serializers standardSerializers = (_$serializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      )
      ..addBuilderFactory(
        FullType(BuiltMap),
        () => MapBuilder<String, String>(),
      )
      ..addBuilderFactory(
        FullType(BuiltList, [FullType(SwapConfigCoin)]),
        () => ListBuilder<SwapConfigCoin>(),
      ))
    .build();

// Serializers

Object? serialize<T>(T value) {
  final typeSer = standardSerializers.serializerForType(T) as Serializer<T>;
  if (typeSer == null) {
    throw Exception('Serializer for ${value?.runtimeType} not found');
  }
  return standardSerializers.serializeWith<T>(typeSer, value);
}

Object serializeListOf<T>(dynamic value) {
  return value.map((item) => serialize<T>(item as T)).toList(growable: false)
      as List<dynamic>;
}

// Deserializer

T? deserialize<T>(dynamic value) {
  final typeSer = standardSerializers.serializerForType(T) as Serializer<T>;
  if (typeSer == null) {
    throw Exception('Serializer for ${value?.runtimeType} not found');
  }
  return standardSerializers.deserializeWith<T>(typeSer, value);
}

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(value
    .map((item) => deserialize<T>(item))
    .toList(growable: false) as List<dynamic>);
