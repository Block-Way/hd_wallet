package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.dabank.flutter_dabank.FlutterDabankPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterDabankPlugin.registerWith(registry.registrarFor("com.dabank.flutter_dabank.FlutterDabankPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
