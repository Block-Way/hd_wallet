import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wallet_sdk_flutter/wallet_sdk_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mnemonic;
  String privateKey;

  final String path = "m/44'/%d'/0'/0/0";
  final String password = "";
  final List<String> symbols = ["BTC", "ETH", "BBC"];

  @override
  void initState() {
    super.initState();
  }

  void generateMnemonic() async {
    final mnemonic = await WalletCore.generateMnemonic();
    setState(() {
      this.mnemonic = mnemonic;
    });
  }

  void importMnemonic(BuildContext context) async {
    final wallets = await WalletCore.importMnemonic(
      mnemonic: mnemonic,
      path: path,
      password: password,
      symbols: symbols,
    );

    showBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
          children: wallets.keys
              .map(
                (symbol) => Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(10),
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        symbol,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      InkWell(
                        child: Text('\nAddress: ${wallets[symbol].address}'),
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: wallets[symbol].address));
                        },
                      ),
                      Text('\nPublicKey: ${wallets[symbol].publicKey}\n'),
                    ],
                  ),
                ),
              )
              .toList(),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wallet SDK Test App'),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Mnemonic:"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child: Text(
                    mnemonic ?? 'First you need to create a new mnemonic',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child:
                      Text(privateKey != null ? 'privateKey:$privateKey' : ''),
                ),
                FlatButton(
                  color: Colors.blue[500],
                  child: Text(
                    "Generate Mnemonic",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: generateMnemonic,
                ),
                FlatButton(
                  color: Colors.blue[500],
                  child: Text(
                    "Import Mnemonic",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => importMnemonic(context),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
