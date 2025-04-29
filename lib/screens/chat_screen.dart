// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class SimpleWebView extends StatefulWidget {
//   const SimpleWebView({Key? key}) : super(key: key);

//   @override
//   State<SimpleWebView> createState() => _SimpleWebViewState();
// }

// class _SimpleWebViewState extends State<SimpleWebView> {
//   double progress = 0;
//   String currentUrl = 'https://www.youtube.com'; // Using Flutter.dev as a test URL instead of YouTube

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Simple WebView'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               // Refresh the page
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Progress indicator
//           progress < 1.0
//               ? LinearProgressIndicator(value: progress)
//               : Container(),
          
//           // WebView
//           Expanded(
//             child: InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: WebUri(currentUrl),
//               ),
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   javaScriptEnabled: true,
//                   useShouldOverrideUrlLoading: false, // Disable this to avoid the null issues
//                 ),
//                 android: AndroidInAppWebViewOptions(
//                   useHybridComposition: true,
//                 ),
//               ),
//               onProgressChanged: (controller, progress) {
//                 setState(() {
//                   this.progress = progress / 100;
//                 });
//               },
//               onLoadStop: (controller, url) {
//                 if (url != null) {
//                   setState(() {
//                     currentUrl = url.toString();
//                   });
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserWebView extends StatefulWidget {
  final String initialUrl;
  
  const BrowserWebView({
    Key? key,
    this.initialUrl = 'https://www.google.com',
  }) : super(key: key);

  @override
  State<BrowserWebView> createState() => _BrowserWebViewState();
}

class _BrowserWebViewState extends State<BrowserWebView> {
  InAppWebViewController? webViewController;
  double progress = 0;
  String currentUrl = '';
  bool canGoBack = false;
  bool canGoForward = false;
  String pageTitle = '';
  final TextEditingController urlController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    currentUrl = widget.initialUrl;
  }
  
  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  void updateNavigationButtons() async {
    if (webViewController != null) {
      canGoBack = await webViewController!.canGoBack();
      canGoForward = await webViewController!.canGoForward();
      if (mounted) {
        setState(() {});
      }
    }
  }

  void loadUrl(String url) {
    String completeUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      completeUrl = 'https://$url';
    }
    
    webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(completeUrl)),
    );
    
    // Close the keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Browser'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                      hintText: 'Enter URL',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          urlController.clear();
                        },
                      ),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        loadUrl(value);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (urlController.text.isNotEmpty) {
                      loadUrl(urlController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
          
          // WebView
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.initialUrl),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  useShouldOverrideUrlLoading: false, // Disable this to avoid null issues
                  mediaPlaybackRequiresUserGesture: false,
                  cacheEnabled: true,
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                if (url != null) {
                  setState(() {
                    currentUrl = url.toString();
                    urlController.text = currentUrl;
                  });
                }
              },
              onLoadStop: (controller, url) {
                updateNavigationButtons();
                if (url != null) {
                  setState(() {
                    currentUrl = url.toString();
                    urlController.text = currentUrl;
                  });
                }
                controller.getTitle().then((title) {
                  if (title != null && mounted) {
                    setState(() {
                      pageTitle = title;
                    });
                  }
                });
              },
              onProgressChanged: (controller, progress) {
                if (mounted) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                }
              },
              onTitleChanged: (controller, title) {
                if (title != null && mounted) {
                  setState(() {
                    pageTitle = title;
                  });
                }
              },
            ),
          ),
          
          // Navigation bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: canGoBack
                      ? () {
                          webViewController?.goBack();
                        }
                      : null,
                  color: canGoBack ? Theme.of(context).primaryColor : Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: canGoForward
                      ? () {
                          webViewController?.goForward();
                        }
                      : null,
                  color: canGoForward ? Theme.of(context).primaryColor : Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    webViewController?.reload();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    webViewController?.loadUrl(
                      urlRequest: URLRequest(url: WebUri(widget.initialUrl)),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: currentUrl.isNotEmpty
                      ? () {
                          // Implement sharing functionality here
                          // You would typically use a package like share_plus
                          // Share.share(currentUrl);
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}