package one.sugar.wallet_sdk_flutter;

import java.nio.ByteBuffer;

public class WalletUtils {

    /**
     * bytes to hex string
     * @param src byte
     * @return string
     */
    public static String bytesToHexString(byte[] src) {
        StringBuilder stringBuilder = new StringBuilder("");
        if (src == null || src.length <= 0) {
            return null;
        }
        for (int i = 0; i < src.length; i++) {
            int v = src[i] & 0xFF;
            String hv = Integer.toHexString(v);
            if (hv.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(hv);
        }
        return stringBuilder.toString();
    }

    /**
     * hex to byte
     * @param hex
     * @return
     */
    public static byte[] hexToByte(String hex) {
        int m = 0, n = 0;
        int byteLen = hex.length() / 2; // 每两个字符描述一个字节
        byte[] ret = new byte[byteLen];
        for (int i = 0; i < byteLen; i++) {
            m = i * 2 + 1;
            n = m + 1;
            int intVal = Integer.decode("0x" + hex.substring(i * 2, m) + hex.substring(m, n));
            ret[i] = Byte.valueOf((byte) intVal);
        }
        return ret;
    }


    /**
     * join byte
     * @param bytes
     * @return byte[]
     */
    public static byte[] joinByte(byte[]... bytes) {
        int length = 0;
        for (byte[] item : bytes) {
            length += item.length;
        }

        ByteBuffer buff = ByteBuffer.allocate(length);
        for (byte[] item : bytes) {
            buff.put(item);
        }
        return buff.array();
    }

}
