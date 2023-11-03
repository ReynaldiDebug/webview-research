import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:research_webview_for_retailer_conn/const.dart';

class HeadlessWebviewScreen extends StatefulWidget {
  const HeadlessWebviewScreen({super.key});

  @override
  State<HeadlessWebviewScreen> createState() => _HeadlessWebviewScreenState();
}

class _HeadlessWebviewScreenState extends State<HeadlessWebviewScreen> {
  late HeadlessInAppWebView? headlessInAppWebView;
  late InAppWebViewController inAppWebViewController;

  String loadedURL = "";
  List<CookieData> cookies = [];

  @override
  void initState() {
    super.initState();
    headlessInAppWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(cookieListerURL)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          supportZoom: false,
          useShouldOverrideUrlLoading: true,
        ),
      ),
      onWebViewCreated: (controller) {
        const snackBar = SnackBar(
          content: Text('HeadlessInAppWebView created!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        inAppWebViewController = controller;
      },
      onConsoleMessage: (controller, consoleMessage) {
        final snackBar = SnackBar(
          content: Text('Console Message: ${consoleMessage.message}'),
          duration: const Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLoadStart: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStart $url'),
          duration: const Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          loadedURL = url?.toString() ?? '';
        });
      },
      onLoadStop: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStop $url'),
          duration: const Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          loadedURL = url?.toString() ?? '';
        });
        await Future.delayed(const Duration(milliseconds: 500));
        List<dynamic> cookieData = (await controller.callAsyncJavaScript(
                functionBody: "return window.READ_COOKIES()"))
            ?.value;

        List<CookieData> _cookies = [];
        cookieData.forEach((element) {
          try {
            _cookies.add(
                CookieData(name: element['name'], value: element['value']));
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        });
        setState(() {
          cookies = _cookies;
        });
      },
    );
    headlessInAppWebView?.run();
  }

  @override
  void dispose() {
    super.dispose();
    headlessInAppWebView?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text("Headless Webview"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Loaded URL: $loadedURL",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "List Cookies:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cookies.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      key: Key("Cookie$index"),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 10,
                        title: Text(
                          'NAME: ${cookies[index].name}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        dense: true,
                        horizontalTitleGap: 0,
                        leading: const Icon(Icons.web, color: Colors.white),
                        subtitle: Text('VALUE: ${cookies[index].value}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
