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
