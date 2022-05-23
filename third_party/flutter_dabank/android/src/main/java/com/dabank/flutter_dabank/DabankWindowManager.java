package com.dabank.flutter_dabank;


import android.app.Activity;
import android.os.Build;
import android.view.WindowManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DabankWindowManager {
    public static void changeFlags(Activity activity, MethodCall call, MethodChannel.Result result) {
        final int flags = call.argument("flags");
        final String check = validLayoutParams(flags);
        if (check != null) {
            result.error("error", check, null);
            return;
        }

        if (activity == null) {
            result.error("error", "activity is null", null);
            return;
        }

        if (call.method.equals("addFlags")) {
            activity.getWindow().addFlags(flags);
            result.success(true);
        }

        if (call.method.equals("clearFlags")) {
            activity.getWindow().clearFlags(flags);
            result.success(true);
        }
    }

    /**
     * @param flags
     * @return null valid ,other invalid
     */
    static private String validLayoutParams(int flags) {
        for (int i = 0; i < Integer.SIZE; i++) {
            int flag = (1 << i);
            if ((flags & flag) == 1) {
                if (!validLayoutParam(flag)) {
                    return "invalid flag specification: " + Integer.toHexString(flag);
                }
            }
        }

        return null;
    }

    static private boolean validLayoutParam(int flag) {
        switch (flag) {
            case WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON:
            case WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM:
            case WindowManager.LayoutParams.FLAG_DIM_BEHIND:
            case WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN:
            case WindowManager.LayoutParams.FLAG_FULLSCREEN:
            case WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED:
            case WindowManager.LayoutParams.FLAG_IGNORE_CHEEK_PRESSES:
            case WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON:
            case WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR:
            case WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN:
            case WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS:
            case WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE:
            case WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE:
            case WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL:
            case WindowManager.LayoutParams.FLAG_SCALED:
            case WindowManager.LayoutParams.FLAG_SECURE:
            case WindowManager.LayoutParams.FLAG_SHOW_WALLPAPER:
            case WindowManager.LayoutParams.FLAG_SPLIT_TOUCH:
            case WindowManager.LayoutParams.FLAG_WATCH_OUTSIDE_TOUCH:
                return true;
            case WindowManager.LayoutParams.FLAG_BLUR_BEHIND:
                return !(Build.VERSION.SDK_INT >= 15);
            case WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD:
                return (Build.VERSION.SDK_INT >= 5 && Build.VERSION.SDK_INT < 26);
            case WindowManager.LayoutParams.FLAG_DITHER:
                return !(Build.VERSION.SDK_INT >= 17);
            case WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS:
                return (Build.VERSION.SDK_INT >= 21);
            case WindowManager.LayoutParams.FLAG_LAYOUT_ATTACHED_IN_DECOR:
                return (Build.VERSION.SDK_INT >= 22);
            case WindowManager.LayoutParams.FLAG_LAYOUT_IN_OVERSCAN:
                return (Build.VERSION.SDK_INT >= 18);
            case WindowManager.LayoutParams.FLAG_LOCAL_FOCUS_MODE:
                return (Build.VERSION.SDK_INT >= 19);
            case WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED:
                return !(Build.VERSION.SDK_INT >= 27);
            case WindowManager.LayoutParams.FLAG_TOUCHABLE_WHEN_WAKING:
                return !(Build.VERSION.SDK_INT >= 20);
            case WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION:
            case WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS:
                return (Build.VERSION.SDK_INT >= 19);
            case WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON:
                return !(Build.VERSION.SDK_INT >= 27);
            default:
                return false;
        }
    }

}
