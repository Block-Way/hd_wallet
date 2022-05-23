package com.dabank.flutter_hdkey;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class FlutterHDKeyCoreReal {
    private static final int WRITE_WAIT_MILLIS = 1000;
    private static final int READ_WAIT_MILLIS = 1000;

    private static final String READ_SUCCESS_CODE = "9000";

    // 模块管理接口
    private static final byte GET_ABOUT_TAG = (byte) 0x01; // 获取模块关于信息
    private static final byte SET_PIN_CODE_TAG = (byte) 0x03; // 新建或修改硬件访问密钥
    private static final byte ACCESS_BY_PIN_CODE_TAG = (byte) 0x04; // 硬件模块接入验证(登录)

    static String[] allFunc = new String[]{"request"}; //"hasHDKey", "connectHDKey",

    static UsbSerialPort port;
    static UsbSerialDriver driver;

    static void log(String str) {
        if (BuildConfig.DEBUG) {
            Log.e("isme CoreReal", str);
        }
    }

    static public void callFunc(MethodCall call, Result result, Activity activity) {
        try {
            switch (call.method) {
                case "hasHDKey":
                    result.success(hasHDKey(activity));
                    break;
                case "connectHDKey":
                    connectHDKey(call, result, activity);
                    break;
                case "request":
                    request(call, result);
                    break;
//                case "getInfo":
//                    getInfo(call, result, activity);
//                    break;
//                case "validatePin":
//                    validatePin(call, result);
//                    break;
//                case "setPin":
//                    setPin(call, result);
//                    break;
//                case "changePin":
//                    changePin(call, result);
//                    break;
//                case "getMnemonicList":
//                    getMnemonicList(call, result);
//                    break;
            }
        } catch (Exception e) {
            result.error("error", e.getMessage(), null);
        }
    }

    static void connectHDKey(MethodCall call, Result result, Activity activity) {
        if (driver != null && port != null && port.isOpen()) {
            result.success(true);
            return;
        }

        UsbManager manager = (UsbManager) activity.getSystemService(Context.USB_SERVICE);

        // TODO check device permission
        // requestPermission(UsbDevice device, PendingIntent pi) 

        UsbDeviceConnection connection = manager.openDevice(driver.getDevice());
        if (connection == null) {
            result.error("-1", "DEVICE_NOT_FOUNT", null);
            return;
        }
        port = driver.getPorts().get(0);
        try {
            port.open(connection);
            port.setParameters(115200, 8, UsbSerialPort.STOPBITS_1, UsbSerialPort.PARITY_NONE);
            result.success(true);
        } catch (Exception ex) {
            result.error("-2", "OPEN_CONNECTION_FAILED", null);
            ex.printStackTrace();
        }
    }


    static void request(MethodCall call, Result result) {
        try {
            final byte[] bytes = call.argument("bytes");
            final String resultType = call.argument("type");
            final int id = call.argument("id");

            log("bytes:"+ Arrays.toString(bytes));
            log("resultType:"+resultType);
            log("id:"+ id);

            byte[] res = writeAndRead(id, bytes);
            if (resultType.equals("int")) {
                final int data = StringUtils.bytesReverseToInt(res);
                result.success(data);
            } else if(resultType.equals("string")){
                final String data = new String(res);
                result.success(data);
            }else if(resultType.equals("hex")){
               final String data =  StringUtils.bytesToHex(res);
                result.success(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.error("-1", "REQUEST_FAIL:" + e.getMessage(), null);
        }
    }

    static void getInfo(MethodCall call, Result result, Activity activity) {
        try {
            int id = getId();
            byte[] bytes = new RequestBytesBuilder()
                    .setId(id)
                    .setTag(GET_ABOUT_TAG)
                    .build(true);

            byte[] res = writeAndRead(id, bytes);
            final String data = new String(res);
            result.success(data);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("-1", "GET_INFO_FAIL" + e.getMessage(), null);
        }
    }


    static void validatePin(MethodCall call, Result result) {
        final String pin = call.argument("pin");
        try {
            int id = getId();
            byte[] bytes = new RequestBytesBuilder()
                    .setId(id)
                    .setTag(ACCESS_BY_PIN_CODE_TAG)
                    .addParams(pin.getBytes())
                    .build(true);
            byte[] res = writeAndRead(id, bytes);
            final int data = StringUtils.bytesReverseToInt(res);
            result.success(data);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("-1", "VALIDATE_PIN_FAIL" + e.getMessage(), null);
        }

    }

    static void setPin(MethodCall call, Result result) {
//        final String pin = call.argument("pin");
    }

    static void changePin(MethodCall call, Result result) {
        final String oldPin = call.argument("oldPin");
        final String newPin = call.argument("newPin");

        try {
            int id = getId();
            byte[] bytes = new RequestBytesBuilder()
                    .setId(id)
                    .setTag(SET_PIN_CODE_TAG)
                    .addParams(StringUtils.intToBytes(6, 1))
                    .addParams(oldPin.getBytes())
                    .addParams(StringUtils.intToBytes(6, 1))
                    .addParams(newPin.getBytes())
                    .build(true);

            byte[] res = writeAndRead(id, bytes);
            final int data = StringUtils.bytesReverseToInt(res);
            result.success(data);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("-1", "CHANGE_PIN_FAIL" + e.getMessage(), null);
        }
    }

    static void getMnemonicList(MethodCall call, Result result) {

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

    // todo remove
    static int getId() {
        return 1;
    }

    /**
     * 写入并读取
     *
     * @param bytes 写入数据
     * @return byte[] 读取的数据
     * @throws Exception ex
     */
    static  byte[] writeAndRead(int interfaceId, byte[] bytes) throws Exception {
        Exception error = new Exception("read failed no content");
        Exception error1 = new Exception("read length not match");

        // 写入
        port.write(bytes, WRITE_WAIT_MILLIS);
        // 读取
        byte[] receiveBytes = new byte[1024];
        int receiveLength = port.read(receiveBytes, READ_WAIT_MILLIS);

        if (receiveLength == 0) {
            throw error;
        }

        byte[] dest = new byte[receiveLength];
        System.arraycopy(receiveBytes, 0, dest, 0, receiveLength);

        ByteArrayInputStream bais = new ByteArrayInputStream(dest);
        DataInputStream dis = new DataInputStream(bais);
        // 数据包长度 4
        byte[] lengthBytes = new byte[4];
        dis.read(lengthBytes);
        int length = StringUtils.bytesReverseToInt(lengthBytes);

        // 响应序号 4
        byte[] idBytes = new byte[4];
        dis.read(idBytes);
        int id = StringUtils.bytesReverseToInt(idBytes);

        // 响应状态码 2
        byte[] codeBytes = new byte[2];
        dis.read(codeBytes);
        String code = StringUtils.bytesReverseToHex(codeBytes);
        byte[] result;

        if (READ_SUCCESS_CODE.equals(code)) {
            // 接口标识 1
            byte tag = dis.readByte();
            // 接口返回值长度 4
            byte[] resLengthBytes = new byte[4];
            dis.read(resLengthBytes);
            int resLength = StringUtils.bytesReverseToInt(resLengthBytes);

            byte[] out = new byte[resLength];
            int len = dis.read(out);

            if (len == resLength) {
                result = out;
            } else {
                throw error1;
            }
        } else {
            throw new Exception("read failed code: " + code);
        }

        try {
            bais.close();
            dis.close();
        } catch (Exception e) {
            Log.d("isme", "Stream Close Exception");
        }

        if (result != null) {
            return result;
        } else {
            throw new Exception("read failed code: " + code);
        }
    }

}
