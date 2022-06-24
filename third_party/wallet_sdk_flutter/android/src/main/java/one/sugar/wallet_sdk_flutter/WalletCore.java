package one.sugar.wallet_sdk_flutter;

import java.util.HashMap;
import crypto.Crypto;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import wallet.Wallet;
import wallet.WalletOptions;
import wallet.Wallet_;

public class WalletCore {
    static String[] allFunc = new String[]{
            "generateMnemonic",
            "importMnemonic",
            "validateMnemonic",
            "signTx",
            "signMsg",
            "signMsgWithPKAndBlake",
            "exportPrivateKey"
    };

    static public void callFunc(MethodCall call, Result result) {
        switch (call.method) {
            case "generateMnemonic":
                generateMnemonic(result);
                break;
            case "validateMnemonic":
                validateMnemonic(call, result);
                break;
            case "importMnemonic":
                importMnemonic(call, result);
                break;
            case "signTx":
                signTx(call, result);
                break;
            case "signMsg":
                signMsg(call, result);
                break;
            case "exportPrivateKey":
                exportPrivateKey(call, result);
                break;
            case "signMsgWithPKAndBlake":
                signMsgWithPKAndBlake(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    /**
     * generate mnemonic
     * @param result mnemonic
     */
    static private void generateMnemonic(Result result) {
        try {
            String mnemonic = Wallet.newMnemonic();
            result.success(mnemonic);
        } catch (Exception e) {
            result.error("GenerateMnemonicError", e.getMessage(), null);
        }
    }

    /**
     * validate mnemonic
     * @param call mnemonic
     * @param result bool
     */
    static private void validateMnemonic(MethodCall call, Result result) {
        try {
            String mnemonic = String.valueOf(call.arguments);
            Wallet.validateMnemonic(mnemonic);
            result.success(true);
        } catch (Exception e) {
            result.error("MnemonicError", "Invalid mnemonic", null);
        }
    }

    /**
     * import mnemonic
     * @param call params
     * @param result key pair list
     */
    static private void importMnemonic(MethodCall call, Result result) {
        try {
            String mnemonic = call.argument("mnemonic");
            String symbolString = call.argument("symbols");
            try {
                Wallet.validateMnemonic(mnemonic);
            } catch (Exception e) {
                result.error("MnemonicError", "Mnemonic is invalid:" + e.getMessage(), null);
                return;
            }
            Wallet_ wallet;
            try {
                wallet = getWalletByCall(call);
            } catch (Exception e) {
                result.error("ImportMnemonicError", "error when getWalletInstance：" + e.getMessage(), null);
                return;
            }
            String[] symbols = symbolString.split(",", 0);
            HashMap<String, HashMap<String, String>> keyInfo = new HashMap<String, HashMap<String, String>>();
            for (String symbol : symbols) {
                HashMap<String, String> keys = new HashMap<String, String>();
                keys.put("publicKey", wallet.derivePublicKey(symbol));
                keys.put("address", wallet.deriveAddress(symbol));
                keys.put("privateKey", wallet.derivePrivateKey(symbol));

                keyInfo.put(symbol, keys);
            }
            result.success(keyInfo);
        } catch (Exception e) {
            result.error("ImportMnemonicError", e.getMessage(), null);
        }
    }

    /**
     * export symbol private key by mnemonic
     *
     * @param call mnemonic params
     * @param result private key
     */
    static private void exportPrivateKey(MethodCall call, Result result) {
        try {
            final String symbol = call.argument("symbol");
            final Wallet_ wallet = getWalletByCall(call);
            final String privateKey = wallet.derivePrivateKey(symbol);
            result.success(privateKey);
        } catch (Exception e) {
            result.error("ExportPrivateKeyError", e.getMessage(), null);
        }
    }

    /**
     * sing msg with private key
     *
     * @param call private key ,msg
     * @param result sing msg
     */
    static private void signMsgWithPKAndBlake(MethodCall call, Result result) {
        try {
            final String privateKey = call.argument("privateKey");
            final String msg = call.argument("msg");

            final byte[] blake2bByte = Crypto.blake2b256(msg.getBytes());

            final byte[] privateKeyByte = Crypto.hexDecodeThenReverse(privateKey);
            byte[] parentSign = Crypto.ed25519sign(privateKeyByte,blake2bByte);
            result.success(WalletUtils.bytesToHexString(parentSign));
        } catch (Exception e) {
            result.error("SignMsgError", e.getMessage(), null);
        }
    }

    /**
     * sing msg by mnemonic
     *
     * @param call mnemonic params
     * @param result msg sing hex data
     */
    static private void signMsg(MethodCall call, Result result) {
        try {
            String mnemonic = call.argument("mnemonic");
            String msg = call.argument("msg");
            String symbol = call.argument("symbol");
            try {
                Wallet.validateMnemonic(mnemonic);
            } catch (Exception e) {
                result.error("MnemonicError", "Mnemonic is invalid", null);
                return;
            }
            Wallet_ wallet = getWalletByCall(call);

            // msg 签名
            String privateKey = wallet.derivePrivateKey(symbol);
            byte[] privateKeyByte = Crypto.hexDecodeThenReverse(privateKey);
            byte[] sign = Crypto.ed25519sign(privateKeyByte, msg.getBytes());
            String msgHex = WalletUtils.bytesToHexString(sign);
            result.success(msgHex);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("SignMsgError", e.getMessage(), null);
        }
    }

    /**
     * sing tx
     * @param call
     * @param result
     */
    static private void signTx(MethodCall call, Result result) {
        try {
            final Wallet_ wallet = getWalletByCall(call);
            String mnemonic = call.argument("mnemonic");
            String rawTx = call.argument("rawTx");
            String symbol = call.argument("symbol");
            try {
                Wallet.validateMnemonic(mnemonic);
            } catch (Exception e) {
                result.error("MnemonicError", "Mnemonic is invalid", null);
                return;
            }
            String signTx = wallet.sign(symbol, rawTx);
            result.success(signTx);
        } catch (Exception e) {
            e.printStackTrace();
            result.error("SignError", e.getMessage(), null);
        }
    }

    /**
     * create wallet instance
     * @param call
     * @return
     * @throws Exception
     */
    static private Wallet_ getWalletByCall(MethodCall call) throws Exception {
        String mnemonic = call.argument("mnemonic");
        String path = call.argument("path");
        String password = call.argument("password");
        boolean beta = call.argument("beta");
        boolean useBip44 = call.argument("useBip44");
        boolean shareAccountWithParentChain = call.argument("shareAccountWithParentChain");

        Wallet.validateMnemonic(mnemonic);

        Wallet_ wallet = getWalletInstance(useBip44, mnemonic, path, password, beta, shareAccountWithParentChain);
        return wallet;
    }


    /**
     * @params password: salt
     */
    static private Wallet_ getWalletInstance(boolean useBip44, String mnemonic, String path,
                                             String password, boolean beta,
                                             boolean shareAccountWithParentChain) {
        WalletOptions options = new WalletOptions();

        options.add(Wallet.withPathFormat(path));
        options.add(Wallet.withPassword(password));
        options.add(Wallet.withShareAccountWithParentChain(shareAccountWithParentChain));

        if (useBip44) {
            // compatible imtoken
            options.add(Wallet.withFlag(Wallet.FlagBBCUseStandardBip44ID));
        }

        Wallet_ wallet = null;
        try {
            wallet = Wallet.buildWalletFromMnemonic(mnemonic, beta, options);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wallet;
    }
}























