import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:research_webview_for_retailer_conn/const.dart';
import 'package:research_webview_for_retailer_conn/cookies-manager-screen.dart';
import 'package:research_webview_for_retailer_conn/headless-webview-screen.dart';
import 'package:research_webview_for_retailer_conn/webview-1.dart';
import 'package:research_webview_for_retailer_conn/webview-2.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexScreen extends StatelessWidget {
  IndexScreen({super.key});

  final GlobalKey webview1Key = GlobalKey(debugLabel: "Webview1");
  final GlobalKey webview2Key = GlobalKey(debugLabel: "Webview2");
  final GlobalKey webviewHeadlessKey = GlobalKey(debugLabel: "webviewHeadless");
  final GlobalKey cookieManagerScreenKey =
      GlobalKey(debugLabel: "cookieManagerKey");

  // Function to copy text to the clipboard
  void copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(
      content: Text('Text copied to clipboard: $text'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Webview Research"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebView1(key: webview1Key)),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text(
                    "Go To Webview 1",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebView2(key: webview2Key)),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text(
                    "Go To Webview 2",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            HeadlessWebviewScreen(key: webviewHeadlessKey)),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text(
                    "Go To: Headless Webview",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            CookieManagerScreen(key: cookieManagerScreenKey)),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text(
                    "Go To: Cookies Manager Example Use",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => launchUrl(Uri.parse(cookieListerURL)),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text(
                    "Open Test Site to Device Browser",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
