part of invitation_ui_module;

class _GetInvitationListParams {
  _GetInvitationListParams(this.coinInfo);
  final AssetCoin coinInfo;

  @override
  String toString() {
    return '_GetInvitationListParams(coinInfo: $coinInfo)';
  }
}

class InvitationListPage extends HookWidget {
  static const routeName = '/invitation/list';
  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(settings, InvitationListPage());
  }

  @override
  Widget build(BuildContext context) {
    final coinInfo = useState<AssetCoin>(null);
    final request = useBehaviorStreamController<
        CSListViewParams<_GetInvitationListParams>>();

    void loadDefaultCoin(InvitationListVM viewModel) {
      final coins = viewModel.getInvitationCoins();
      if (coins?.isNotEmpty == true) {
        final defaultCoin = coinInfo.value ?? coins.first;
        coinInfo.value = defaultCoin;
        request.add(
          CSListViewParams.withParams(_GetInvitationListParams(defaultCoin)),
        );
      }
    }

    return CSScaffold(
      title: tr('invitation:defi_list_title'),
      actions: [
        if (coinInfo.value != null)
          StoreConnector<AppState, InvitationListVM>(
            converter: InvitationListVM.fromStore,
            builder: (context, viewModel) {
              return CSButton(
                padding: context.edgeHorizontal,
                label: coinInfo.value.name,
                flat: true,
                textStyle: context.textBody(),
                onPressed: () {
                  InvitationCoinSelectPage.open().then((coin) {
                    if (coin.chain != coinInfo.value.chain ||
                        coin.symbol != coinInfo.value.symbol) {
                      coinInfo.value = coin;
                      viewModel.clearInvitationList();
                      request.add(
                        CSListViewParams.withParams(
                          _GetInvitationListParams(coin),
                        ),
                      );
                    }
                  });
                },
                cmpRight: Padding(
                  padding: context.edgeLeft5,
                  child: Icon(
                    CSIcons.More,
                    size: 10,
                    color: context.bodyColor,
                  ),
                ),
              );
            },
          )
        else
          SizedBox()
      ],
      child: StoreConnector<AppState, InvitationListVM>(
        distinct: true,
        converter: InvitationListVM.fromStore,
        onInitialBuild: (viewModel) {
          loadDefaultCoin(viewModel);
        },
        builder: (context, viewModel) => ModelPermissionView(
          moduleName: ModuleName.invitation,
          onRefreshSuccess: () {
            loadDefaultCoin(viewModel);
          },
          child: CSListViewStream<_GetInvitationListParams>(
            emptyLabel: tr('invitation:list_empty_tips'),
            emptyImageUrl: 'assets/images/empty_record.png',
            requestStream: request,
            onLoadData: (params) {
              return viewModel.loadInvitationList(
                params.isRefresh,
                params.skip,
                params.params.coinInfo,
              );
            },
            itemCount: viewModel.invitations.length,
            itemBuilder: (context, index) {
              return _buildItem(context, viewModel.invitations[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Invitation item) {
    final date = formatDate(
      DateTime.fromMillisecondsSinceEpoch((item.createAt ?? 0) * 1000),
    );
    final address = item.address ?? '';

    return CSContainer(
      margin: context.edgeAll.copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                tr('invitation:defi_list_lbl_address'),
                style: context.textSecondary(),
              ),
              Spacer(),
              CSButtonIcon(
                size: 18,
                borderRadius: 4,
                padding: EdgeInsets.all(0),
                icon: CSIcons.Copy,
                containerSize: 20,
                margin: EdgeInsets.symmetric(horizontal: 2),
                onPressed: () {
                  copyTextToClipboard(address);
                  Toast.show(tr('global:msg_copy_success'));
                },
              ),
            ],
          ),
          SizedBox(height: context.edgeSize),
          Text(address, style: context.textBody()),
          SizedBox(height: context.edgeSize),
          Text(date, style: context.textSecondary()),
        ],
      ),
    );
  }
}
