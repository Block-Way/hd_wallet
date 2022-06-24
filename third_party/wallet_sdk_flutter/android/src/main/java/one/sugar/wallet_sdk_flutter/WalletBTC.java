package one.sugar.wallet_sdk_flutter;


import java.util.List;
import java.util.Map;
import btc.BTCAddress;
import btc.BTCAmount;
import btc.BTCOutputAmount;
import btc.BTCTransaction;
import btc.BTCUnspent;
import btc.Btc;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class WalletBTC {
    static String[] allFunc = new String[]{"createBTCTransaction", "validateBTCAddress"};

    static public void callFunc(MethodCall call, Result result) {
        switch (call.method) {
            case "createBTCTransaction":
                createBTCTransaction(call, result);
                break;
            case "validateBTCAddress":
                validateBTCAddress(call, result);
            default:
                result.notImplemented();
        }
    }

    /**
     * create btc transaction
     * @param call params
     * @param result
     */
    static private void createBTCTransaction(MethodCall call, Result result) {
        try {
            List<Map<String, Object>> unspentList = call.argument("utxos");
            String toAddress = call.argument("toAddress");
            double amount = call.argument("amount");
            String fromAddress = call.argument("fromAddress");
            long feeRate = Long.parseLong(call.argument("feeRate").toString());
            boolean isBeta = call.argument("beta");
            long chainID = isBeta ? Btc.ChainRegtest : Btc.ChainMainNet;
            boolean isGetFee = call.argument("isGetFee");

            BTCUnspent unspent = new BTCUnspent();
            for (Map<String, Object> item : unspentList) {
                String txId = String.valueOf(item.get("txId"));
                long vOut = Long.valueOf(String.valueOf(item.get("vOut")));
                Double vAmount = Double.valueOf(String.valueOf(item.get("vAmount")));
                unspent.add(txId, vOut, vAmount, "", "");
            }

            BTCOutputAmount outputAmount = new BTCOutputAmount();
            outputAmount.add(new BTCAddress(toAddress, chainID), new BTCAmount(amount));
            BTCAddress changeAddress = new BTCAddress(fromAddress, chainID);

            BTCTransaction trans = new BTCTransaction(unspent, outputAmount, changeAddress, feeRate, chainID);
            String data = isGetFee ? String.valueOf(trans.getFee()) : trans.encodeToSignCmd();
            result.success(data);
        } catch (Exception e) {
            result.error("TransactionError", e.getMessage(), null);
        }
    }

    /**
     * validate btc address
     * @param call address
     * @param result bool
     */
    static private void validateBTCAddress(MethodCall call, Result result) {
        try {
            String address = call.argument("address");
            boolean isBeta = call.argument("beta");

            long chainID = isBeta ? Btc.ChainRegtest : Btc.ChainMainNet;
            new BTCAddress(address, chainID);
            result.success(true);
        } catch (Exception e) {
            result.error("AddressError", e.getMessage(), null);
        }
    }
}
