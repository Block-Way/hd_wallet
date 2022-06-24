package one.sugar.wallet_sdk_flutter;

import eth.BigInt;
import eth.ERC20InterfaceABIHelper;
import eth.ETHAddress;
import eth.ETHTransaction;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class WalletETH {
    static String[] allFunc = new String[]{"createETHTransaction", "validateETHAddress"};

    static public void callFunc(MethodCall call, Result result) {
        switch (call.method) {
            case "createETHTransaction":
                createETHTransaction(call, result);
                break;
            case "validateETHAddress":
                validateETHAddress(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    /**
     * create eth transaction
     * @param call
     * @param result hex
     */
    static private void createETHTransaction(MethodCall call, Result result) {
        try {
            long nonce = Long.valueOf(String.valueOf(call.argument("nonce")));
            long gasLimit = Long.valueOf(String.valueOf(call.argument("gasLimit")));
            long amount = Long.valueOf(String.valueOf(call.argument("amount")));
            long gasPrice = Long.valueOf(String.valueOf(call.argument("gasPrice")));

            String address = call.argument("address");
            String contract = call.argument("contract");
            boolean isContract = contract != null && !contract.equals("");

            ETHAddress ethAddress = new ETHAddress(address); // 对方eth 钱包地址
            BigInt bigAmount = new BigInt(amount);
            BigInt bigGasPrice = new BigInt(gasPrice);

            ETHTransaction trans = null;
            if (isContract) {
                ERC20InterfaceABIHelper erc20ABI = new ERC20InterfaceABIHelper();
                byte[] erc20Data = erc20ABI.packedTransfer(ethAddress, bigAmount);
                ETHAddress ethToAddress = new ETHAddress(contract);
                trans = new ETHTransaction(nonce, ethToAddress, new BigInt(0), gasLimit, bigGasPrice, erc20Data);
            } else {
                trans = new ETHTransaction(nonce, ethAddress, bigAmount, gasLimit, bigGasPrice, null);
            }

            String data = trans.encodeRLP();
            result.success(data);
        } catch (Exception e) {
            result.error("TransactionError", e.getMessage(), null);
        }
    }

    /**
     * validate eth address
     * @param call
     * @param result
     */
    static private void validateETHAddress(MethodCall call, Result result) {
        try {
            String address = call.argument("address");
            new ETHAddress(address);
            result.success(true);
        } catch (Exception e) {
            result.error("AddressError", e.getMessage(), null);
        }
    }
}
