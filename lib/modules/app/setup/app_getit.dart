part of app_module;

class AppGetIt {
  static Future<void> initGetIt() async {
    // Init Project Modules
    await moduleAppInitGetIt();
    await moduleCommonInitGetIt();
    await moduleAssetInitGetIt();
    await moduleWalletInitGetIt();
    await moduleInvitationInitGetIt();
    await moduleTradeInitGetIt();
    await moduleInvestInitGetIt();
    await moduleAdmissionInitGetIt();
    await moduleSwapInitGetIt();
  }
}
