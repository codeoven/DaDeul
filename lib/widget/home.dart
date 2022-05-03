import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: SafeArea(
            bottom: false,
            child: WebView(
              initialUrl: 'https://homepick.cafe24.com/default',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith("mailto:") ||
                    request.url.startsWith("tel:")) {
                  launch(request.url);

                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          ),
        ),
      ),
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();

          return false;
        } else {
          return true;
        }
      },
    );
  }
}
