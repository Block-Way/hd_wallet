part of app_module;

abstract class ModulePermissionVM
    implements Built<ModulePermissionVM, ModulePermissionVMBuilder> {
  factory ModulePermissionVM(
          [void Function(ModulePermissionVMBuilder) updates]) =
      _$ModulePermissionVM;

  ModulePermissionVM._();

  @nullable
  int get configState;

  @nullable
  int get tradeConfigState;

  @nullable
  int get investConfigState;

  @nullable
  int get swapConfigState;

  @nullable
  int get communityConfigState;

  @nullable
  ConfigUpdateData get newVersionData;

  @nullable
  BuiltMap<String, String> get disabledModules;

  // Methods
  @BuiltValueField(compare: false)
  Future<bool> Function(
    String moduleName,
    ModulePermissionState permission,
  ) get doRefreshModulePermission;

  @BuiltValueField(compare: false)
  ModulePermissionState Function(
    String moduleName,
  ) get getModulePermission;

  @BuiltValueField(compare: false)
  static ModulePermissionVM fromStore(Store<AppState> store) {
    return ModulePermissionVM(
      (viewModel) => viewModel
        ..newVersionData = store.state.commonState.newVersion?.data?.toBuilder()
        ..disabledModules = store.state.commonState.disabledModules?.toBuilder()
        ..configState = store.state.commonState.configState
        ..investConfigState = store.state.investState.configState
        ..tradeConfigState = store.state.tradeState.configState
        ..swapConfigState = store.state.swapState.configState
        ..communityConfigState = store.state.communityState.configState
        ..doRefreshModulePermission = (moduleName, permission) async {
          final state = store.state;

          // 通用 config 判断 ，功能关闭 也是刷新 config 获取最新的配置
          if (permission == ModulePermissionState.needConfig ||
              permission == ModulePermissionState.disable) {
            await store.dispatchFuture(CommonActionLoadConfig());
          }

          // 特定页面 参数判断
          if (moduleName == ModuleName.trade &&
              state.tradeState.configState != ConfigState.success.index) {
            await store.dispatchFuture(TradeActionLoadConfig());
          }

          // 特定页面 参数判断
          if (moduleName == ModuleName.mint &&
              state.investState.configState != ConfigState.success.index) {
            await store.dispatchFuture(InvestActionLoadConfig());
          }

          if (moduleName == ModuleName.swap &&
              state.swapState.configState != ConfigState.success.index) {
            await store.dispatchFuture(SwapActionLoadConfig());
          }

          if (moduleName == ModuleName.community &&
              state.communityState.configState != ConfigState.success.index) {
            await store.dispatchFuture(CommunityActionLoadConfig());
          }

          return true;
        }
        ..getModulePermission = (moduleName) {
          // common config check
          if (viewModel.configState == ConfigState.loading.index) {
            return ModulePermissionState.loading;
          } else if (viewModel.configState == ConfigState.error.index) {
            return ModulePermissionState.needConfig;
          }

          // disable 在版本判断之前
          if (GetIt.I<ModulePermissionUtils>().isDisable(moduleName)) {
            return ModulePermissionState.disable;
          }

          if (GetIt.I<ModulePermissionUtils>().isOldVersion(moduleName)) {
            return ModulePermissionState.needUpdate;
          }

          // model params check
          if (moduleName == ModuleName.trade &&
              viewModel.tradeConfigState == ConfigState.error.index) {
            return ModulePermissionState.needModuleConfig;
          }

          if (moduleName == ModuleName.mint &&
              viewModel.investConfigState == ConfigState.error.index) {
            return ModulePermissionState.needModuleConfig;
          }

          if (moduleName == ModuleName.swap &&
              viewModel.swapConfigState == ConfigState.error.index) {
            return ModulePermissionState.needModuleConfig;
          }

          if (moduleName == ModuleName.community &&
              viewModel.communityConfigState == ConfigState.error.index) {
            return ModulePermissionState.needModuleConfig;
          }

          // default
          return ModulePermissionState.valid;
        },
    );
  }
}
