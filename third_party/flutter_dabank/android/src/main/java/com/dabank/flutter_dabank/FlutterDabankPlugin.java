package com.dabank.flutter_dabank;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterDabankPlugin
 */
public class FlutterDabankPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler, SendEvent {
    private static final String CHANNEL_NAME = "flutter_dabank";
    private static final String CHANNEL_NAME_EVENT = "flutter_dabank_event";
    private MethodChannel channel;
    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;
    private Activity activity;

    private UpdateManager updateManager;

    void log(String str) {
        if (BuildConfig.DEBUG) {
            Log.e("isme DabankPlugin", str);
        }
    }

    public static void registerWith(Registrar registrar) {
        final FlutterDabankPlugin plus = new FlutterDabankPlugin();
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(plus);

        EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL_NAME_EVENT);
        eventChannel.setStreamHandler(plus);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        log("call.method:" + call.method);

        switch (call.method) {
            case "updateAppAndroid":
                final String url = call.argument("url");
                if (updateManager != null) {
                    updateManager.cancel();
                }
                updateManager = new UpdateManager(activity, url, this);
                updateManager.start();
                break;

            case "cancelUpdate":
                if (updateManager != null) {
                    updateManager.cancel();
                    updateManager = null;
                }
                break;
            case "installApk":
                new UpdateManager(activity, "", this).installApk();
                break;
            case "addFlags":
            case "clearFlags":
                DabankWindowManager.changeFlags(activity, call, result);
                break;
            default:
                result.notImplemented();
        }
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        eventChannel.setStreamHandler(null);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME);
        channel.setMethodCallHandler(this);

        eventChannel = new EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME_EVENT);
        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    @Override
    public void send(Map<String, String> data) {
        if (eventSink != null) {
            eventSink.success(data);
        } else {
            log("flutter not add listener");
        }
    }
}
