# meow-money
## In this document:

1. [How to run this project?](#how-to-run-this-project)
2. [Folder structure](#folder-structure)
3. [Dependencies](#dependencies)

## How to run this project?

> ⚠️ **Make sure Flutter CLI is installed.**

1. Clone this repository:

```
git clone https://github.com/cuongceg/meow-money.git
```

2. Install all dependencies (libraries):

```
flutter pub get
```

3. Run the project:

```
flutter run
```

Using this command, the terminal will look somthing like this:

```
Connected devices:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.22621.2134]
Chrome (web)      • chrome  • web-javascript • Google Chrome 116.0.5845.187
Edge (web)        • edge    • web-javascript • Microsoft Edge 116.0.1938.76
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (or "q" to quit):
```

If you have an [Android virtual device](https://developer.android.com/studio/run/managing-avds?hl=en), or an Android Device connected via USB that enabled [USB Debugging](https://developer.android.com/studio/debug/dev-options?hl=en#debugging), it will show up in the connected devices as well.

Running the app on mobile devices is recommended.

## Folder structure

```
├── android/ - Contains build artifacts for Android
├── assets/ - Contains static files (images, videos, audios)
├── ios/ - Contains build artifacts for iOS
├── lib/ - Contains source code
    ├── models/ - Contains classes of real-world objects
    ├── pages/ - Contains widgets represented as pages or screens
        ├──home/ - Contains home screens
        ├──login/ -Contains login and sign up screens
    ├── services/ - Contains classes controll models
    ├── const_value.dart - Contains const value and methods
    ├── firebase_options.dart - Contains current platform for Firebase
    ├── main.dart - Entry point (code starts here)
├── macos/ - Contain build artifacts for macOS
├── test/ - Contains code for testing
├── web/ - Contains static web files (HTML, CSS)
├── analysis_options.yaml - Contains rules for linter (flutter_lints)
├── pubspec.lock - Contains exact, locked version of dependencies
├── pubspec.yaml - Contains approximate version of dependencies
├── README.md - This documents
```

## Dependencies

> _All of the dependencies are listed in [pubspec.yaml](pubspec.yaml).

* [firebase_core](https://pub.dev/packages/firebase_core):Flutter plugin for Firebase Core, enabling connecting to multiple Firebase apps.

* [firebase_auth](https://pub.dev/packages/firebase_auth):Flutter plugin for Firebase Auth, enabling authentication using passwords, phone numbers and identity providers like Google, Facebook and Twitter.

* [cloud_firestore](https://pub.dev/packages/cloud_firestore):Flutter plugin for Cloud Firestore, a cloud-hosted, noSQL database with live synchronization and offline support on Android and iOS.

* [provider](https://pub.dev/packages/provider):A wrapper around InheritedWidget to make them easier to use and more reusable.

* [wave](https://pub.dev/packages/wave):Widget for displaying waves with custom color, duration, floating and blur effects.

* [chart](https://pub.dev/packages/fl_chart):A highly customizable Flutter chart library that supports Line Chart, Bar Chart, Pie Chart, Scatter Chart, and Radar Chart.

* [carousel_slider](https://pub.dev/packages/carousel_slider):A carousel slider widget, support infinite scroll and custom child widget.

* [floating_bottom_bar](https://pub.dev/packages/flutter_floating_bottom_bar):A flutter package that allows showing a floating widget that can be used as a tab bar, bottom navigation bar, etc. The widget reacts to scrolling events too.

* [calculator](https://pub.dev/packages/flutter_simple_calculator):Flutter widget that provides simple calculator. You can easily integrate a calculator to your apps.