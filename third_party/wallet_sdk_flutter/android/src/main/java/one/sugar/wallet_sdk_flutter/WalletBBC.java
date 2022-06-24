package one.sugar.wallet_sdk_flutter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bbc.TemplateInfo;
import bbc.TxBuilder;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import bbc.Bbc;
import bbc.KeyInfo;

public class WalletBBC {
    static String[] allFunc = new String[]{
            "createBBCTransaction",
            "validateBBCAddress",
            "createBBCDexOrderTemplateData",
            "createBBCKeyPair",
            "createBBCFromPrivateKey",
            "addressBBCToPublicKey"
    };

    static public void callFunc(MethodCall call, Result result) {
        switch (call.method) {
            case "createBBCTransaction":
                createBBCTransaction(call, result);
                break;
            case "validateBBCAddress":
                validateBBCAddress(call, result);
                break;
            case "createBBCDexOrderTemplateData":
                createBBCDexOrderTemplateData(call, result);
                break;
            case "createBBCKeyPair":
                createBBCKeyPair(call, result);
                break;
            case "createBBCFromPrivateKey":
                createBBCFromPrivateKey(call, result);
                break;
            case "addressBBCToPublicKey":
                addressBBCToPublicKey(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    /**
     * generate bbc key pair
     * @param call path key
     * @param result key pair
     */
    static private void createBBCKeyPair(MethodCall call, Result result) {
        try {
            final String bip44Path = call.argument("bip44Path");
            final String bip44Key = call.argument("bip44Key");

            final bip44.Deriver de = Bbc.newSymbolBip44Deriver(
                    null, //symbol
                    bip44Path, //bip44Path
                    bip44Key, //bip44Key
                    null); //seed

            final HashMap<String, String> map = new HashMap<String, String>();
            map.put("address", de.deriveAddress());
            map.put("publicKey", de.derivePublicKey());
            map.put("privateKey", de.derivePrivateKey());
            result.success(map);
        } catch (Exception e) {
            result.error("createBBCKeyPair", e.getMessage(), null);
        }
    }

    /**
     * generate bbc key pair by private key
     * @param call private key
     * @param result key pair
     */
    static private void createBBCFromPrivateKey(MethodCall call, Result result) {
        try {
            final String privateKey = call.argument("privateKey");

            final KeyInfo info = Bbc.parsePrivateKey(privateKey);

            final HashMap<String, String> map = new HashMap<String, String>();
            map.put("address", info.getAddress());
            map.put("publicKey", info.getPublicKey());
            map.put("privateKey", info.getPrivateKey());
            result.success(map);
        } catch (Exception e) {
            result.error("CreateBBCFromPrivateKeyError", e.getMessage(), null);
        }
    }

    /**
     * address to public key
     * @param call address
     * @param result public key
     */
    static private void addressBBCToPublicKey(MethodCall call, Result result) {
        try {
            final String address = call.argument("address");
            final String pubKey = Bbc.address2pubk(address);
            result.success(pubKey);
        } catch (Exception e) {
            result.error("AddressBBCToPublicKeyError", e.getMessage(), null);
        }
    }

    /**
     * create bbc transaction
     * @param call params
     * @param result hex
     */
    static private void createBBCTransaction(MethodCall call, Result result) {
        try {
            List<Map<String, Object>> utxos = call.argument("utxos");
            String address = call.argument("address");
            long timestamp = Long.valueOf(String.valueOf(call.argument("timestamp")));
            String anchor = call.argument("anchor");
            double amount = call.argument("amount");
            double fee = call.argument("fee");
            int version = call.argument("version");
            int lockUntil = call.argument("lockUntil");
            long type = Long.valueOf(String.valueOf(call.argument("type")));
            String templateData = call.argument("templateData");


            TxBuilder txBuilder = Bbc.newTxBuilder();
            txBuilder
                    .setAnchor(anchor)
                    .setTimestamp(timestamp)
                    .setVersion(version)
                    .setType(type)
                    .setLockUntil(lockUntil)
                    .setAddress(address)
                    .setAmount(amount)
                    .setFee(fee);

            // data
            String dataWithFmt = call.argument("dataWithFmt");
            String dataWithUUID = call.argument("dataWithUUID");
            String data = call.argument("data");

            int dataType = 0;
            if (call.hasArgument("dataType")) {
                dataType = call.argument("dataType");
            }

            if(data != null){
                switch (dataType) {
                    case 0: // setData String
                        txBuilder.setData(dataWithFmt, data.getBytes());
                        break;
                    case 1: //  setRawData hex
                        txBuilder.setRawData(WalletUtils.hexToByte(data));
                        break;
                    case 2: //setDataWith
                        txBuilder.setDataWith(dataWithUUID, timestamp, dataWithFmt, data.getBytes());
                        break;
                }
            }

            for (Map<String, Object> item : utxos) {
                String txId = String.valueOf(item.get("txId"));
                int vOut = (int) item.get("vOut");
                txBuilder.addInput(txId, (byte) vOut);
            }

            if (templateData != null && !"".equals(templateData)) {
                txBuilder.addTemplateData(templateData);
            }

            String hex = txBuilder.build();
            result.success(hex);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("TransactionError", e.getMessage(), null);
        }
    }

    /**
     * create bbc dex order with template data
     * @param call params
     * @param result raw hex
     */
    static private void createBBCDexOrderTemplateData(MethodCall call, Result result) {
        try {
            String tradePair = call.argument("tradePair");
            long price = Long.valueOf(String.valueOf(call.argument("price")));
            int fee = call.argument("fee");
            int validHeight = call.argument("validHeight");
            String sellerAddress = call.argument("sellerAddress");
            String recvAddress = call.argument("recvAddress");
            String matchAddress = call.argument("matchAddress");
            String dealAddress = call.argument("dealAddress");
            long timestamp = Long.valueOf(String.valueOf(call.argument("timestamp")));


            TemplateInfo info;
            try {
                info = Bbc.createTemplateDataDexOrder(
                        sellerAddress,
                        tradePair,
                        price,
                        fee,
                        recvAddress,
                        validHeight,
                        matchAddress,
                        dealAddress,
                        timestamp
                );
            } catch (Exception e) {
                result.error("CreateError", e.getMessage(), null);
                return;
            }

            HashMap<String, String> data = new HashMap<>();
            data.put("address", info.getAddress());
            data.put("rawHex", info.getRawHex());
            result.success(data);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("Error", e.getMessage(), null);
        }
    }

    /**
     * validate bbc address
     * @param call address
     * @param result bool
     */
    static private void validateBBCAddress(MethodCall call, Result result) {
        try {
            String address = call.argument("address");
            Bbc.address2pubk(address);
            result.success(true);
        } catch (Exception e) {
            result.error("AddressError", e.getMessage(), null);
        }
    }
}
