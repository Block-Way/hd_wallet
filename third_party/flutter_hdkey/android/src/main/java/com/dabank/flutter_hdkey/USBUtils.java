package com.dabank.flutter_hdkey;

import android.content.Context;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.util.Log;

import java.util.HashMap;

public class USBUtils {
    /**
     * 是否有对应id 的 device
     *
     * @param context
     * @param productId
     * @return
     */
    static boolean hasDeviceById(Context context, int productId) {
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);

        HashMap<String, UsbDevice> devices = usbManager.getDeviceList();
        for (String key : devices.keySet()) {
            UsbDevice device = devices.get(key);
            if (device != null && productId == device.getProductId()) {
                return true;
            }
        }
        return false;
    }
}
