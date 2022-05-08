package com.dabank.flutter_hdkey;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class FlutterHDKeyCore {
    static String[] allFunc = new String[]{"hasHDKey", "connectHDKey", "getInfo", "validatePin", "setPin", "changePin", "getMnemonicList",};

    public static SharedPreferences sharedPreferences;

    static final String TEST_PIN = "TEST_PIN";
    static final String TEST_MNEMONIC = "TEST_MNEMONIC";

    // only test use
    public static void initTestCode(Activity activity) {
        sharedPreferences = activity.getSharedPreferences("hdkey_test", Context.MODE_PRIVATE);
    }

    static public void callFunc(MethodCall call, Result result, Activity activity) {
        try {
            switch (call.method) {
                case "hasHDKey":
                    result.success(hasHDKey(activity));
                    break;
                case "connectHDKey":
                    connectHDKey(call, result);
                    break;
                case "getInfo":
                    getInfo(call, result);
                    break;
                case "validatePin":
                    validatePin(call, result);
                    break;
                case "setPin":
                    setPin(call, result);
                    break;
                case "changePin":
                    changePin(call, result);
                    break;
                case "getMnemonicList":
                    getMnemonicList(call, result);
                    break;
            }
        } catch (Exception e) {
            result.error("error", e.getMessage(), null);
        }
    }

    static void connectHDKey(MethodCall call, Result result) throws Exception {
        Thread.sleep(1_000);
        result.success(true);
    }

    static void getInfo(MethodCall call, Result result) {
        final Map<String, Object> map = new HashMap<>();
        final String localPin = sharedPreferences.getString(TEST_PIN, "");

        map.put("isInitialized", !localPin.equals(""));
        map.put("solt0", 0);
        map.put("solt1", 0);
        map.put("solt2", 0);
        result.success(map);
    }

    static void validatePin(MethodCall call, Result result) {
        final String pin = call.argument("pin");
        final String localPin = sharedPreferences.getString(TEST_PIN, "");
        result.success(pin.equals(localPin));
    }

    static void setPin(MethodCall call, Result result) {
        final String pin = call.argument("pin");

        final String localPin = sharedPreferences.getString(TEST_PIN, "");
        if (localPin.equals("")) {
            final boolean state = sharedPreferences.edit().putString(TEST_PIN, pin).commit();
            result.success(state);
        } else {
            result.error("-1", "PIN_CODE_USED", null);
        }
    }

    static void changePin(MethodCall call, Result result) {
        final String oldPin = call.argument("oldPin");
        final String newPin = call.argument("newPin");

        final String localPin = sharedPreferences.getString(TEST_PIN, "");

        if (!oldPin.equals(localPin)) {
            result.error("-1", "OLD_PIN_FAIL", null);
        } else if (newPin.length() != 6) {
            result.error("-2", "NEW_PIN_LENGTH_FAIL", null);
        } else {
            final boolean state = sharedPreferences.edit().putString(TEST_PIN, newPin).commit();
            result.success(state);
        }
    }

    static void getMnemonicList(MethodCall call, Result result) {
        List<String> list = new ArrayList<>();
        list.add("camera modify dragon food remember police produce avoid frequent jewel foil shed");
        list.add("wasp panda myself husband elevator arch nuclear ghost bean legend perfect curve");

        result.success(list);
    }

    static void setMnemonicList(MethodCall call, Result result) {

    }

    /**
     * 是否有HDKey
     *
     * @param context
     * @return
     */
    static boolean hasHDKey(Context context) {
        try {
            return USBUtils.hasDeviceById(context, 9987);
        } catch (Exception e) {
            return false;
        }
    }
}
