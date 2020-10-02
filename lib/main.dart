import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.goBack();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.goForward();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.reload();
                }
              },
            )
          ],
        ),
        body: Container(
            child: InAppWebView(
              initialUrl: "https://flutter.dev/",
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  )
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop: (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
      ),
    );
  }
}