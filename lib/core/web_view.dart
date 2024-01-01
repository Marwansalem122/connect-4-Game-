import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebView extends StatefulWidget {
  final String url;
   WebView({required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;
 @override
 void initState() {
   super.initState();
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('connect four'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}