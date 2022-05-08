package com.dabank.flutter_hdkey;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbManager;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Arrays;

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
 * FlutterHDKeyPlugin
 */
public class FlutterHDKeyPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
    private static final String CHANNEL_NAME = "flutter_hdkey";
    private static final String CHANNEL_NAME_EVENT = "flutter_hdkey_event";
    private MethodChannel channel;
    private EventChannel eventChannel;
    private Activity activity;
    private EventChannel.EventSink eventSink;
    BroadcastReceiver usbReceiver;

    void log(String str) {
        if (BuildConfig.DEBUG) {
            Log.e("isme HDKeyPlugin", str);
        }
    }

    public static void registerWith(Registrar registrar) {
        final FlutterHDKeyPlugin plus = new FlutterHDKeyPlugin();
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(plus);

        EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL_NAME_EVENT);
        eventChannel.setStreamHandler(plus);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        log( "call.method:" + call.method);

        if (Arrays.asList(FlutterHDKeyCoreReal.allFunc).contains(call.method)) {
            FlutterHDKeyCoreReal.callFunc(call, result, activity);
            return;
        }


        if (Arrays.asList(FlutterHDKeyCore.allFunc).contains(call.method)) {
            FlutterHDKeyCore.callFunc(call, result, activity);
        }

        // test
        switch (call.method) {
            case "testDeviceAttached":
                sendEvent("DeviceAttached");
                break;
            case "testDeviceDetached":
                sendEvent("DeviceDetached");
                break;
            case "clearTestData":
                FlutterHDKeyCore.sharedPreferences.edit().clear().commit();
                break;
            default:
                result.notImplemented();
        }
    }

    private void initReceiver() {
        final boolean hasHDKey = FlutterHDKeyCore.hasHDKey(activity);
        if (hasHDKey) {
            sendEvent("DeviceAttached");
        }

        usbReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                final String action = intent.getAction();
                if (UsbManager.ACTION_USB_DEVICE_ATTACHED.equals(action)) {
                    if (FlutterHDKeyCore.hasHDKey(activity)) {
                        sendEvent("DeviceAttached");
                    }
                }

                if (UsbManager.ACTION_USB_DEVICE_DETACHED.equals(action)) {
                    if (!FlutterHDKeyCore.hasHDKey(activity)) {
                        sendEvent("DeviceDetached");
                    }
                }
            }
        };

        IntentFilter filter = new IntentFilter();
        filter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED);
        filter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED);
        activity.registerReceiver(usbReceiver, filter);
    }


    private void sendEvent(Object data) {
        if (eventSink != null) {
            eventSink.success(data);
        } else {
            log( "flutter not add listener");
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
        initReceiver();
        FlutterHDKeyCore.initTestCode(activity);
    }

    @Override
    public void onDetachedFromActivity() {
        if (usbReceiver != null && activity != null) {
            activity.unregisterReceiver(usbReceiver);
            usbReceiver = null;
        }

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
}
