# sugar

A Sweet Flutter project made with Love and Overtime.

## Getting Started

### flutter version
```sh
flutter --version  
```
use Flutter 1.22.6
### Install

```sh
# Git Pre-Hooks

brew install Arkweid/lefthook/lefthook

yarn global add commitlint

lefthook install

```

### Commands

```sh
# Code generation (.g.dart)
flutter packages pub run build_runner build
```

```sh
# App icons
flutter pub run flutter_launcher_icons:main
```

```sh
# App Splash Screen
flutter pub pub run flutter_native_splash:create
```

```sh
# Update all packages
flutter packages upgrade
```

```sh
# Update translations
flutter packages pub run tool/build_locales
```

```sh
# Run dev tool locally
flutter pub global run devtools
```

```sh
# lint error `flutter analyze` error because of analyzer state leftover from a different flutter revision
git clean -xffd
```
### 测试钱包数据
钱包名称: A
密码: 1234qweR  
助记词: retire turtle lazy eager churn alcohol cup cannon frequent romance wink better
私钥: d2feeab10e27831b0a3aa8d9b1040bc722975cf9d050d66cd3732c8a90915903
公钥: 77f2b1217377f62cbb34c5b72b63c6c17fdb5e9e0b6173b4edcb19d03922c0f5
地址: 1yq024eeg375yvd3kc45swqpvfz0wcrsbpz2k9escysvq68dhy9vtqe58

fork: 00000000a137256624bda82aec19645b1dd8d41311ceac9b5c3e49d2822cd49f
fork: 0000000190e31a56bea3d263cc271649bf72ef1bf5ca8aa7e271ba9dd754f2da

addr2: 1549pyzf8dhx7r4x40k5j80f12btkpqfprjp134bcgcrjn963nzsx57xb

```json
{
    "transaction" : {
        "txid" : "3cd2623a8cfbbef88fa78a98890fcc5af59fd31d293c4cb8ad870cb0fa4d87c8",
        "version" : 1,
        "type" : "token",
        "time" : 1648004347,
        "nonce" : 1,
        "from" : "1yq024eeg375yvd3kc45swqpvfz0wcrsbpz2k9escysvq68dhy9vtqe58",
        "to" : "1549pyzf8dhx7r4x40k5j80f12btkpqfprjp134bcgcrjn963nzsx57xb",
        "amount" : "1.0000000000",
        "gaslimit" : 10000,
        "gasprice" : "0.0000010000",
        "gasused" : 10000,
        "txfee" : "0.0100000000",
        "data" : "00",
        "sig" : "3985419e7727d474f520a132badf62c9c93b95827f4144319451a560b8fe39997dbfa678dc3bfb87c0d70d31b468dc505ff0c97fffa8d80a203052b0af2f3708",
        "fork" : "00000000769872b2afcc290a025b23362202fc3ba715c7fc27bd96b2aec73e4b",
        "height" : 5996,
        "blockhash" : "0000176c8f363ae096c8c403ee93286e43c70126c5271e92b3c355a631d18baa",
        "confirmations" : 0,
        "serialization" : "01000000fb8c3a6200000000769872b2afcc290a025b23362202fc3ba715c7fc27bd96b2aec73e4b01000000000000000177f2b1217377f62cbb34c5b72b63c6c17fdb5e9e0b6173b4edcb19d03922c0f501f3afc3a42a31836c9111acc4f65d3bf512e10124cb04a4137c7a6ce87d6f132900000000000000000000000000000000000000000000000000000002540be4000000000000000000000000000000000000000000000000000000000000002710000000000000000000000000000000000000000000000000000000000000271000403985419e7727d474f520a132badf62c9c93b95827f4144319451a560b8fe39997dbfa678dc3bfb87c0d70d31b468dc505ff0c97fffa8d80a203052b0af2f3708"
    }
}
```