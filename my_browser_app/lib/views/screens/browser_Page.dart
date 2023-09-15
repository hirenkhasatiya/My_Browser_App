import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:my_browser_app/controller/web_controller.dart';
import 'package:provider/provider.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<pagecontroller>(builder: (context, Provider, child) {
      return WillPopScope(
        onWillPop: () async {
          if (Provider.canback) {
            Provider.back();
          }
          return !Provider.canback;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Browser"),
            centerTitle: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            actions: [
              Visibility(
                visible: Provider.cangoback,
                child: IconButton(
                  onPressed: () {
                    Provider.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp),
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.Refresh();
                },
                icon: const Icon(Icons.refresh),
              ),
              Visibility(
                visible: Provider.cangoforward,
                child: IconButton(
                  onPressed: () {
                    Provider.forward();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ],
            leading: PopupMenuButton(
              offset: const Offset(25, 40),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Select Search Engine"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioMenuButton(
                              value: Provider.browserurl,
                              groupValue: Provider.allurl["duckduckgo"],
                              onChanged: (val) {
                                Provider.changeBrowser(
                                    browserName: "duckduckgo");
                                Navigator.of(context).pop();
                              },
                              child: Text("duckduckgo"),
                            ),
                            RadioMenuButton(
                              value: Provider.browserurl,
                              groupValue: Provider.allurl["yahoo"],
                              onChanged: (val) {
                                Provider.changeBrowser(browserName: "yahoo");
                                Navigator.of(context).pop();
                              },
                              child: Text("yahoo"),
                            ),
                            RadioMenuButton(
                              value: Provider.browserurl,
                              groupValue: Provider.allurl["google"],
                              onChanged: (val) {
                                Provider.changeBrowser(browserName: "google");
                                Navigator.of(context).pop();
                              },
                              child: Text("Google"),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.screen_search_desktop_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Search Engine"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Share Page"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    showModalBottomSheet(
                        barrierColor: Colors.blue.shade50.withOpacity(0.6),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            height: 600,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  "All Bookmarks",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("All Bookmarks"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == ConnectivityResult.none) {
                    return const Center(
                        child: Image(
                            image: AssetImage("assets/images/error.gif")));
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: double.infinity,
                          child: TextField(
                            onSubmitted: (value) {
                              Provider.search(value: value);
                            },
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                              url: Uri.parse(Provider.currenturl),
                            ),
                            onLoadStart: (controller, url) {
                              return Provider.init(
                                  webviewController: controller);
                            },
                            onLoadStop: (controller, url) {
                              return Provider.init(
                                  webviewController: controller);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.indigo,
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
