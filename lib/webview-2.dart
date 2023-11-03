import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:research_webview_for_retailer_conn/const.dart';

class WebView2 extends StatefulWidget {
  const WebView2({super.key});

  @override
  State<WebView2> createState() => _WebView2State();
}

class _WebView2State extends State<WebView2> {
  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text("WEBVIEW 2"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await inAppWebViewController.reload();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: InAppWebView(
                    onWebViewCreated: (controller) {
                      inAppWebViewController = controller;
                    },
                    initialUrlRequest:
                        URLRequest(url: Uri.parse(cookieListerURL)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        supportZoom: false,
                        useShouldOverrideUrlLoading: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
