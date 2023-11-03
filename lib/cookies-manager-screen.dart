import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:research_webview_for_retailer_conn/const.dart';

class CookieManagerScreen extends StatefulWidget {
  const CookieManagerScreen({Key? key}) : super(key: key);

  @override
  _CookieManagerScreenState createState() => _CookieManagerScreenState();
}

class _CookieManagerScreenState extends State<CookieManagerScreen> {
  final CookieManager cookieManager = CookieManager.instance();
  List<CookieData> cookies = [];

  Future<void> getAllCookies() async {
    List<Cookie> _cookies = [];
    if (Platform.isAndroid) {
      _cookies =
          await cookieManager.getCookies(url: Uri.parse(cookieListerURL));
    } else if (Platform.isIOS) {
      _cookies = await cookieManager.ios.getAllCookies();
    }

    final List<CookieData> tempCookies = [];
    _cookies.forEach((element) {
      tempCookies.add(CookieData(name: element.name, value: element.value));
    });

    setState(() {
      cookies = tempCookies;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCookies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Text("Cookie Manager"),
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
                child: const Text(
                  "Data from WebStorageManager Object",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
