package one.sugar.wallet_sdk_flutter;

import java.util.Arrays;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** WalletSdkFlutterPlugin */
public class WalletSdkFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wallet_sdk_flutter");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (Arrays.asList(WalletCore.allFunc).contains(call.method)) {
      WalletCore.callFunc(call,result);
    } else if (Arrays.asList(WalletBBC.allFunc).contains(call.method))  {
      WalletBBC.callFunc(call,result);
    }  else if (Arrays.asList(WalletBTC.allFunc).contains(call.method))  {
      WalletBTC.callFunc(call,result);
    } else if (Arrays.asList(WalletETH.allFunc).contains(call.method))  {
      WalletETH.callFunc(call,result);
    }else{
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
