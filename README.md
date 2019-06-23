# flutter_native_config

A plugin to access native configuration for both Android and iOS from Flutter.

For some third party integrations, for example Google and Facebook, the API keys are usually stored
in the native realm -- namely **AndroidManifest.xml** and **Info.plist** -- and there's no way to
access these values from Flutter. Until now, that it :)

This plugin allows you to access those values directly from Flutter so you don't have to include then
in Dart code in addition to the native realm.

## Usage

Import `package:flutter_native_config/flutter_native_config.dart`, and use the public function
`FlutterNativeConfig.getConfig()` to retrieve a value from both Android and iOS. Because most
of the time the key names are different for these two platforms, the function accepts a separate
key for each platform.

Example:

```dart
import 'package:flutter_native_config/flutter_native_config.dart';

Future<String> get appId {
  return FlutterNativeConfig.getConfig<String>(
    android: 'version_name',
    ios: 'CFBundleName',
  );
}

Future<String> get appVersion {
  return FlutterNativeConfig.getConfig<String>(
    android: 'version_code',
    ios: 'CFBundleShortVersionString',
  );
}

Future.wait([appId, appVersion]).then((result) {
  print('App: ${result[0]} v${result[1]}');
});
```

## Issues

For reporting bugs, incompatibilities, or feature requests, please
[submit a new issue](https://github.com/noordawod/flutter_native_config/issues/new).

## Contributing

If you wish to contribute a fix or a new feature, please submit a pr.

## License

This plugin is released under the [MIT license](https://github.com/noordawod/flutter_native_config/LICENSE).
