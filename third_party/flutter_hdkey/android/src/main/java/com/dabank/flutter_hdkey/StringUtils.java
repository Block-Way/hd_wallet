package com.dabank.flutter_hdkey;


import java.nio.ByteBuffer;

public class StringUtils {
    /**
     * 字节转十六进制
     *
     * @param b 需要进行转换的byte字节
     * @return 转换后的Hex字符串
     */
    public static String byteToHex(byte b) {
        String hex = Integer.toHexString(b & 0xFF);
        if (hex.length() < 2) {
            hex = "0" + hex;
        }
        return hex;
    }

    /**
     * 字节数组转16进制
     *
     * @param bytes 需要转换的byte数组
     * @return 转换后的Hex字符串
     */
    public static String bytesToHex(byte[] bytes) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() < 2) {
                sb.append(0);
            }
            sb.append(hex);
        }
        return sb.toString();
    }

    /**
     * Hex字符串转byte
     *
     * @param inHex 待转换的Hex字符串
     * @return 转换后的byte
     */
    public static byte hexToByte(String inHex) {
        return (byte) Integer.parseInt(inHex, 16);
    }

    /**
     * hex字符串转byte数组
     *
     * @param inHex 待转换的Hex字符串
     * @return 转换后的byte数组结果
     */
    public static byte[] hexToByteArray(String inHex) {
        int hexLength = inHex.length();
        byte[] result;
        if (hexLength % 2 == 1) {
            //奇数
            hexLength++;
            result = new byte[(hexLength / 2)];
            inHex = "0" + inHex;
        } else {
            //偶数
            result = new byte[(hexLength / 2)];
        }
        int j = 0;
        for (int i = 0; i < hexLength; i += 2) {
            result[j] = hexToByte(inHex.substring(i, i + 2));
            j++;
        }
        return result;
    }

    /**
     * 合并两个字节数组
     *
     * @param bt1 第一个数组
     * @param bt2 第二个数组
     * @return 合并后的数组
     */
    public static byte[] byteMerger(byte[] bt1, byte[] bt2) {
        byte[] bt3 = new byte[bt1.length + bt2.length];
        int i = 0;
        for (byte bt : bt1) {
            bt3[i] = bt;
            i++;
        }

        for (byte bt : bt2) {
            bt3[i] = bt;
            i++;
        }
        return bt3;
    }

    /**
     * 翻转字节数组
     *
     * @param bytes 原数组
     * @return 翻转后的数组
     */
    public static byte[] reverseBytes(byte[] bytes) {
        int size = bytes.length;
        byte[] newByte = new byte[size];
        for (int i = 0; i < size; i++) {
            newByte[i] = bytes[size - i - 1];
        }
        return newByte;
    }

    /**
     * 将整数转换为byte数组并指定长度
     *
     * @param a      整数
     * @param length 指定长度
     * @return 转换后的数组
     */
    public static byte[] intToBytes(int a, int length) {
        byte[] bs = new byte[length];
        for (int i = bs.length - 1; i >= 0; i--) {
            bs[i] = (byte) (a % 255);
            a = a / 255;
        }
        return bs;
    }

    /**
     * 将byte数组转换为整数
     *
     * @param bs 要转换的数组
     * @return 转换后的值
     */
    public static int bytesToInt(byte[] bs) {
        int a = ByteBuffer.wrap(bs).getInt();
        return a;
    }

    public static int bytesReverseToInt(byte[] bytes) {
        return bytesToInt(reverseBytes(bytes));
    }

    public static String bytesReverseToHex(byte[] bytes) {
        return bytesToHex(reverseBytes(bytes));
    }
}