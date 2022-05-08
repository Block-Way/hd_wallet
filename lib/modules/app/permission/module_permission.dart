part of app_module;

class ModuleName {
  static const trade = 'TRADE';
  static const mint = 'MINT';
  static const swap = 'SWAP';
  static const community = 'COMMUNITY';
  static const invitation = 'INVITATION';
  static const admission = 'ADMISSION';
}

enum ModulePermissionState {
  loading,
  needConfig,
  needUpdate,
  disable,
  needModuleConfig,
  valid,
}

class ModulePermissionUtils {
  Map<String, String> _disabledModules = {};
  String _currentVersion = '';

  void updateFromConfig(Config config, String version) {
    _currentVersion = version;
    _disabledModules = config?.version?.data?.disabledModules?.toMap() ?? {};
  }

  /// Return True If the config min version is higher then this app version
  bool isOldVersion(String moduleName) {
    final netVersion = _disabledModules[moduleName];
    if (VersionUtils.netIsNew(local: _currentVersion, net: netVersion)) {
      return true;
    }

    return false;
  }

  /// A module is disabled when min version is 0
  bool isDisable(String moduleName) {
    if (_disabledModules.containsKey(moduleName)) {
      final netVersion = _disabledModules[moduleName];
      if (netVersion == '0') {
        return true;
      }
    }
    return false;
  }
}
