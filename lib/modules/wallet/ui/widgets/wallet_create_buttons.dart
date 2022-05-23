part of wallet_ui_module;

class WalletCreateButtons extends StatelessWidget {
  const WalletCreateButtons({
    this.isEmptyPage = false,
    this.isUseDialog = false,
  });

  final bool isEmptyPage;
  final bool isUseDialog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.edgeAll,
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.fromLTRB(46, 3, 46, 3),
          //   margin: isEmptyPage ? context.edgeBottom20 : context.edgeBottom8,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFfefae0),
          //     borderRadius: BorderRadius.vertical(
          //       top: isEmptyPage ? Radius.circular(13.0) : Radius.zero,
          //       bottom: Radius.circular(13.0),
          //     ),
          //   ),
          //   child: Text(
          //     'Support ImToken 2.0 or later to import',
          //     style: context.textTiny(color: context.bodyColor),
          //   ),
          // ),
          Row(
            children: [
              Flexible(
                child: CSButton(
                  label: tr('wallet:import_title'),
                  onPressed: () {
                    if (isUseDialog) {
                      AppNavigator.goBack();
                    }
                    WalletImportPage.open();
                  },
                  bordered: true,
                  backgroundColor: context.bgPrimaryColor,
                ),
              ),
              SizedBox(width: context.edgeSize),
              Flexible(
                child: CSButton(
                  label: tr('wallet:create_title'),
                  onPressed: () {
                    if (isUseDialog) {
                      AppNavigator.goBack();
                    }
                    WalletCreatePage.open();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
