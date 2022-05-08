part of project_domain_module;

abstract class ProjectApplyVM
    implements Built<ProjectApplyVM, ProjectApplyVMBuilder> {
  factory ProjectApplyVM([void Function(ProjectApplyVMBuilder) updates]) =
      _$ProjectApplyVM;
  ProjectApplyVM._();

// Fields
  @nullable
  ProjectCreateParams get lastProjectCreateParams;

  @nullable
  String get projectRules;

  //  Methods

  @BuiltValueField(compare: false)
  double Function({
    @required String chain,
    @required String symbol,
  }) get getCoinBalance;

  @BuiltValueField(compare: false)
  AssetCoin Function({
    @required String chain,
    @required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockHDWallet;

  @BuiltValueField(compare: false)
  Future<void> Function({
    @required ProjectCreateParams params,
    @required Future<WalletPrivateData> Function() onUnlockWallet,
    @required Future<bool> Function(ProjectCreateParams) onConfirmData,
    @required void Function(String txId) onSuccessTransaction,
  }) get doSubmitProject;

  @BuiltValueField()
  Future<void> Function(ProjectCreateParams params) get doSubmitCreateProject;

  @BuiltValueField(compare: false)
  Future<void> Function(ProjectCreateParams params) get doSaveToCache;

  @BuiltValueField(compare: false)
  Future<void> Function() get getProjectConfig;

  static ProjectApplyVM fromStore(Store<AppState> store) {
    return ProjectApplyVM(
      (viewModel) => viewModel
        ..projectRules =
            store.state.projectState?.projectConfig?.instructions ?? ''
        ..lastProjectCreateParams =
            store.state.projectState.lastProjectCreateParams?.toBuilder()
        ..doUnlockHDWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        ..doSubmitProject = ({
          params,
          onUnlockWallet,
          onConfirmData,
          onSuccessTransaction,
        }) {
          return store.dispatchFuture(ProjectActionCreateSubmit(
            params: params,
            onUnlockWallet: onUnlockWallet,
            onConfirmData: onConfirmData,
            onSuccessTransaction: onSuccessTransaction,
          ));
        }
        ..doSubmitCreateProject = (params) {
          return store.dispatchFuture(ProjectActionCreateSuccess(params));
        }
        ..doSaveToCache = (params) {
          return store.dispatchFuture(ProjectActionCreateSaveToCache(
            params,
          ));
        }
        ..getCoinInfo = ({chain, symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getCoinBalance = ({chain, symbol}) {
          return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getProjectConfig = () {
          return store.dispatchFuture(ProjectActionGetConfig());
        },
    );
  }
}
