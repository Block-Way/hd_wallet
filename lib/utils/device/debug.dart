part of utils;

/// Whether the VM is running in debug mode.
///
/// This is useful to decide whether a report should be sent to sentry. Usually
/// reports from dev mode are not very useful, as these happen on developers'
/// workspaces rather than on users' devices in production.
bool get isInDebugMode {
  var inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
