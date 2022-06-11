part of app_module;

/// This class holds the whole application state.
/// Which can include:
/// - auth state
/// - etc.
///
abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([Function(AppStateBuilder) b]) = _$AppState;
  AppState._();

  /// Create a new empty App state
  factory AppState.initialState() => AppState(
        (a) => a
          ..commonState.replace(CommonState())
          ..assetState.replace(AssetState())
          ..walletState.replace(WalletState())
          ..homeState.replace(HomeState())
          //..swapState.replace(SwapState())
          ..tradeState.replace(TradeState())
          ..noticeState.replace(NoticeState())
          ..invitationState.replace(InvitationState())
          ..communityState.replace(CommunityState())
          ..hdkeyState.replace(HDKeyState())
          ..investState.replace(InvestState())
          ..admissionState.replace(AdmissionState())
          ..projectState.replace(ProjectState()),
      );

  factory AppState.fromCache({
    HomeState? homeState,
    TradeState? tradeState,
    NoticeState? noticeState,
    AssetState? assetState,
    WalletState? walletState,
    CommunityState? communityState,
    ProjectState? projectState,
  }) =>
      AppState(
        (a) => a
          ..commonState.replace(CommonState())
          ..assetState.replace(assetState ?? AssetState())
          ..walletState.replace(walletState ?? WalletState())
          ..homeState.replace(homeState ?? HomeState())
          //..swapState.replace(SwapState())
          ..tradeState.replace(tradeState ?? TradeState())
          ..noticeState.replace(noticeState ?? NoticeState())
          ..invitationState.replace(InvitationState())
          ..communityState.replace(communityState ?? CommunityState())
          ..hdkeyState.replace(HDKeyState())
          ..investState.replace(InvestState())
          ..admissionState.replace(AdmissionState())
          ..projectState.replace(projectState ?? ProjectState()),
      );

  // Modules States

  CommonState get commonState;
  AssetState get assetState;
  WalletState get walletState;
  NoticeState get noticeState;
  HomeState get homeState;
  //SwapState get swapState;
  TradeState get tradeState;
  InvitationState get invitationState;
  CommunityState get communityState;
  HDKeyState get hdkeyState;
  InvestState get investState;
  AdmissionState get admissionState;
  ProjectState get projectState;
}
