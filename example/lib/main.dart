//
// Copyright (c) 2019 Noor Dawod. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_native_config/flutter_native_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appId = 'Unknown';
  String _appVersion = '0.0.0';

  @override
  void initState() {
    super.initState();
    retrieveValues();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('App name: $_appId\n'),
            Text('App version: $_appVersion\n'),
          ],
        ),
      ),
    ),
  );

  Future<void> retrieveValues() async {
    String appId;
    String appVersion;

    try {
      // Assuming that AndroidManigest.xml is setup to include 'version_name' meta-data.
      appId = await FlutterNativeConfig.getConfig(
        android: 'version_name',
        ios: 'CFBundleName',
      );

      // Assuming that AndroidManigest.xml is setup to include 'version_code' meta-data.
      appVersion = await FlutterNativeConfig.getConfig(
        android: 'version_code',
        ios: 'CFBundleShortVersionString',
      );
    } on PlatformException {
      appId = 'Failed to get values.';
    }

    if (mounted) {
      setState(() {
        _appId = appId;
        _appVersion = appVersion;
      });
    }
  }

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

  void r() {
    Future.wait([appId, appVersion]).then((result) {
      print('App: ${result[0]} v${result[1]}');
    });
  }
}
