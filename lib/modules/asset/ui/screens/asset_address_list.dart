part of asset_ui_module;

class AssetAddressListPage extends HookWidget {
  const AssetAddressListPage({
    this.coinInfo,
    this.selectAddress,
  });

  final AssetCoin coinInfo;
  final String selectAddress;

  static const routeName = '/asset/address/list';

  static Future<String> open(AssetCoin coinInfo, String selectAddress) {
    return AppNavigator.push<String>(routeName, params: {
      'coinInfo': coinInfo,
      'selectAddress': selectAddress,
    });
  }

  static Route<String> route(RouteSettings settings) {
    final params = settings.arguments as Map<String, dynamic>;
    final selectAddress = params['selectAddress'];
    final coinInfo = params['coinInfo'] as AssetCoin;
    return DefaultTransition<String>(
        settings,
        AssetAddressListPage(
          coinInfo: coinInfo,
          selectAddress: selectAddress?.toString(),
        ));
  }

  void showAddressManageDialog(
    BuildContext context,
    AssetAddressVM viewModel, {
    AssetAddress item,
  }) {
    final options = [
      CSOptionsItem(
        label: tr('global:btn_edit'),
        value: 'edit',
      ),
      CSOptionsItem(
        label: tr('global:btn_delete'),
        color: context.redColor,
        value: 'delete',
      ),
    ];
    showOptionsDialog<String>(
      context,
      options: options,
      onSelected: (value) {
        if (value == 'edit') {
          AssetAddressAddPage.open(coinInfo, item);
        } else if (value == 'delete') {
          showConfirmDialog(
            context,
            content: tr('asset:address_delete_dialog_content'),
            onConfirm: () {
              LoadingDialog.show(context);
              viewModel.submitAddressDelete(coinInfo, item).then((_) {
                Toast.show(tr('asset:address_delete_msg_success'));
                LoadingDialog.dismiss(context);
              }).catchError((e) {
                LoadingDialog.dismiss(context);
                Toast.showError(e);
              });
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams<bool>>();
    final select = useState(0);

    void onSelect(int index, AssetAddressVM viewModel) {
      if (index != select.value) {
        select.value = index;
        viewModel.clearAddressList();
        request.add(CSListViewParams.withParams(
          index == 0,
          delay: index == 0 ? 0 : 1,
        ));
      }
    }

    return CSScaffold(
      headerBgColor: Color(0xFF32383E),
      backgroundColor: Color(0xFF32383E),
      title: tr('asset:address_list_title'),
      child: StoreConnector<AppState, AssetAddressVM>(
        distinct: true,
        converter: AssetAddressVM.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.clearAddressList();
          request.add(CSListViewParams.withParams(true, delay: 0));
        },
        builder: (context, viewModel) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: context.edgeAll,
              child: Wrap(
                runSpacing: context.edgeSize,
                spacing: context.edgeSize,
                // children: [
                //   buildMenu(
                //     context,
                //     tr('asset:address_menu_local'),
                //     select.value,
                //     0,
                //     onSelect,
                //     viewModel,
                //   ),
                //   buildMenu(
                //     context,
                //     tr('asset:address_menu_net'),
                //     select.value,
                //     1,
                //     onSelect,
                //     viewModel,
                //   ),
                // ],
              ),
            ),
            Expanded(
              child: CSListViewStream<bool>(
                key: Key('asset_address_list'),
                emptyLabel: tr('asset:address_list_empty'),
                emptyImageUrl: 'assets/images/empty_record.png',
                requestStream: request,
                onLoadData: (params) {
                  return viewModel.loadAddressList(
                    coin: coinInfo,
                    requestId: params.requestId ?? '',
                    isLocal: params.params,
                  );
                },
                itemCount: viewModel.addressList.length,
                itemBuilder: (context, index) {
                  return buildItem(
                      context, viewModel, viewModel.addressList[index]);
                },
              ),
            ),
            if (select.value == 1)
              Center(
                child: CSButton(
                  label: tr('asset:address_btn_add'),
                  margin: context.edgeVertical,
                  onPressed: () {
                    AssetAddressAddPage.open(coinInfo);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(
    BuildContext context,
    String label,
    int selectIndex,
    int index,
    void Function(int index, AssetAddressVM viewModel) onSelect,
    AssetAddressVM viewModel,
  ) {
    return InkWell(
      onTap: () {
        onSelect(index, viewModel);
      },
      child: Container(
        padding: context.edgeAll8.copyWith(left: 13, right: 13),
        decoration: context.boxDecoration(
            radius: 8,
            color: selectIndex == index
                ? context.primaryColor
                : context.whiteColor),
        child: Text(
          label,
          style: context.textSecondary(
            bold: true,
            color: context.bodyColor,
          ),
        ),
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    AssetAddressVM viewModel,
    AssetAddress item,
  ) {
    final addressStr =
        StringUtils.strCut(item.address, startKeep: 6, endKeep: 6);

    final isSelect = item.address == selectAddress;

    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      onTap: () {
        AppNavigator.popWithResult(item.address);
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isSelect)
                      CSButtonIcon(
                        padding: EdgeInsets.only(
                          right: 2,
                          top: 1,
                        ),
                        margin: context.edgeRight8,
                        containerSize: 16,
                        size: 6,
                        borderRadius: 16,
                        icon: CSIcons.WalletCheck,
                      ),
                    Expanded(
                      child: Text(
                        item.comments ?? '',
                        style: context.textBody(bold: true),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.edgeSize),
                Row(
                  children: [
                    Container(
                      decoration: context.boxDecoration(
                        radius: 5,
                        color: Color(0xFFfffce7),
                      ),
                      padding: context.edgeAll5,
                      child: Text(
                        coinInfo.fullName,
                        style: context.textSmall(
                          color: Color(0xFF94820d),
                        ),
                      ),
                    ),
                    SizedBox(width: context.edgeSizeHalf),
                    Text(addressStr ?? '', style: context.textSmall()),
                  ],
                ),
              ],
            ),
          ),
          if (item.isLocal != true) SizedBox(width: context.edgeSizeHalf),
          if (item.isLocal != true)
            Transform.translate(
              offset: Offset(context.edgeSize, 0),
              child: CSButtonIcon(
                size: 18,
                borderRadius: 4,
                padding: EdgeInsets.zero,
                icon: CSIcons.EvenMore,
                color: context.secondaryColor,
                background: Colors.transparent,
                containerSize: 60,
                margin: EdgeInsets.symmetric(horizontal: 2),
                onPressed: () {
                  showAddressManageDialog(
                    context,
                    viewModel,
                    item: item,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
