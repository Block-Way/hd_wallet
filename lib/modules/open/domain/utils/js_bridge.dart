part of open_domain_module;

/// Represent a message sent from JS to Flutter
class JsBridge {
  JsBridge(
    this.method,
    this.params,
    this.onSuccess,
    this.onError,
  );

  factory JsBridge.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return JsBridge(
      map['method']?.toString(),
      Map.from(map['params'] as Map ?? {}),
      map['onSuccess'] as Function,
      map['onError'] as Function,
    );
  }

  factory JsBridge.fromJson(String source) =>
      JsBridge.fromMap(jsonDecode(source) as Map<String, dynamic>);

  /// Method name to call
  String method;

  /// Method params
  Map params;

  /// Call back called when method is executed successfully
  Function onSuccess;

  /// Call back called when method is executed with error
  Function onError;

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'params': params,
      'onSuccess': onSuccess,
      'onError': onError,
    };
  }

  String toJson() => json.encode(toMap());
}
