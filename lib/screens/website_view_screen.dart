// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class WebsiteViewScreen extends StatefulWidget {
//   final String initialUrl;
//   final String title;

//   const WebsiteViewScreen({
//     Key? key, 
//     required this.initialUrl,
//     this.title = 'Website',
//   }) : super(key: key);

//   @override
//   State<WebsiteViewScreen> createState() => _WebsiteViewScreenState();
// }

// class _WebsiteViewScreenState extends State<WebsiteViewScreen> {
//   InAppWebViewController? _webViewController;
//   double _progress = 0;
//   String _currentUrl = '';
//   bool _isLoading = true;
//   bool _canGoBack = false;
//   bool _canGoForward = false;
//   String _pageTitle = '';
//   bool _hasError = false;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _currentUrl = widget.initialUrl;
//     _pageTitle = widget.title;
//   }

//   Future<bool> _handleBackPressed() async {
//     if (_webViewController != null && await _webViewController!.canGoBack()) {
//       _webViewController!.goBack();
//       return false;
//     }
//     return true;
//   }

//   void _updateNavigationCapabilities() async {
//     if (_webViewController != null) {
//       final backStatus = await _webViewController!.canGoBack();
//       final forwardStatus = await _webViewController!.canGoForward();
      
//       if (mounted) {
//         setState(() {
//           _canGoBack = backStatus;
//           _canGoForward = forwardStatus;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _handleBackPressed,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 _pageTitle.isNotEmpty ? _pageTitle : widget.title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text(
//                 _currentUrl,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[300],
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: () {
//                 if (_webViewController != null && !_isLoading) {
//                   _webViewController!.reload();
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.open_in_browser),
//               onPressed: () async {
//                 if (_currentUrl.isNotEmpty) {
//                   await _webViewController?.loadUrl(
//   urlRequest: URLRequest(url: WebUri(_currentUrl)),
// );

//                 }
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             // Progress indicator
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               height: _isLoading ? 3.0 : 0,
//               child: LinearProgressIndicator(
//                 value: _progress,
//                 backgroundColor: Colors.grey[800],
//                 valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
//               ),
//             ),
            
//             // WebView
//             Expanded(
//               child: Stack(
//                 children: [
//                   InAppWebView(
//                     initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
//                     initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                         useShouldOverrideUrlLoading: true,
//                         mediaPlaybackRequiresUserGesture: false,
//                         javaScriptEnabled: true,
//                         cacheEnabled: true,
//                       ),
//                       android: AndroidInAppWebViewOptions(
//                         useHybridComposition: true,
//                       ),
//                       ios: IOSInAppWebViewOptions(
//                         allowsInlineMediaPlayback: true,
//                       ),
//                     ),
//                     onWebViewCreated: (controller) {
//                       _webViewController = controller;
//                     },
//                     onLoadStart: (controller, url) {
//                       if (url != null) {
//                         setState(() {
//                           _currentUrl = url.toString();
//                           _isLoading = true;
//                           _hasError = false;
//                         });
//                       }
//                     },
//                     onLoadStop: (controller, url) {
//                       if (url != null) {
//                         _updateNavigationCapabilities();
//                         controller.getTitle().then((title) {
//                           if (mounted && title != null) {
//                             setState(() {
//                               _pageTitle = title;
//                               _isLoading = false;
//                             });
//                           }
//                         });
//                       }
//                     },
//                     onProgressChanged: (controller, progress) {
//                       setState(() {
//                         _progress = progress / 100;
//                       });
//                     },
//                     onLoadError: (controller, url, code, message) {
//                       setState(() {
//                         _isLoading = false;
//                         _hasError = true;
//                         _errorMessage = "Error $code: $message";
//                       });
//                     },
//                     onLoadHttpError: (controller, url, statusCode, description) {
//                       setState(() {
//                         _isLoading = false;
//                         _hasError = true;
//                         _errorMessage = "HTTP Error $statusCode: $description";
//                       });
//                     },
//                   ),
                  
//                   // Error view
//                   if (_hasError)
//                     Container(
//                       color: Colors.white,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.error_outline,
//                               color: Colors.red,
//                               size: 60,
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               'Failed to load page',
//                               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                               child: Text(
//                                 _errorMessage,
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 setState(() {
//                                   _hasError = false;
//                                 });
//                                 _webViewController?.reload();
//                               },
//                               icon: const Icon(Icons.refresh),
//                               label: const Text('Try Again'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Theme.of(context).primaryColor,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
            
//             // Bottom navigation bar
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, -1),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios),
//                           onPressed: _canGoBack
//                               ? () {
//                                   _webViewController?.goBack();
//                                 }
//                               : null,
//                           color: _canGoBack ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward_ios),
//                           onPressed: _canGoForward
//                               ? () {
//                                   _webViewController?.goForward();
//                                 }
//                               : null,
//                           color: _canGoForward ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.home),
//                           onPressed: () {
//                             _webViewController?.loadUrl(
//                               urlRequest: URLRequest(url: WebUri(widget.initialUrl)),
//                             );
//                           },
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.share),
//                           onPressed: _currentUrl.isNotEmpty
//                               ? () {
//                                   // Implement share functionality
//                                   // You can use a share package here
//                                 }
//                               : null,
//                           color: _currentUrl.isNotEmpty ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class WebsiteViewScreen extends StatefulWidget {
//   final String initialUrl;
//   final String title;

//   const WebsiteViewScreen({
//     Key? key, 
//     required this.initialUrl,
//     this.title = 'Website',
//   }) : super(key: key);

//   @override
//   State<WebsiteViewScreen> createState() => _WebsiteViewScreenState();
// }

// class _WebsiteViewScreenState extends State<WebsiteViewScreen> {
//   InAppWebViewController? _webViewController;
//   double _progress = 0;
//   String _currentUrl = '';
//   bool _isLoading = true;
//   bool _canGoBack = false;
//   bool _canGoForward = false;
//   String _pageTitle = '';
//   bool _hasError = false;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _currentUrl = widget.initialUrl;
//     _pageTitle = widget.title;
//   }

//   Future<bool> _handleBackPressed() async {
//     if (_webViewController != null && await _webViewController!.canGoBack()) {
//       _webViewController!.goBack();
//       return false;
//     }
//     return true;
//   }

//   void _updateNavigationCapabilities() async {
//     if (_webViewController != null) {
//       final backStatus = await _webViewController!.canGoBack();
//       final forwardStatus = await _webViewController!.canGoForward();
      
//       if (mounted) {
//         setState(() {
//           _canGoBack = backStatus;
//           _canGoForward = forwardStatus;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _handleBackPressed,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 _pageTitle.isNotEmpty ? _pageTitle : widget.title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text(
//                 _currentUrl,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[300],
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: () {
//                 if (_webViewController != null && !_isLoading) {
//                   _webViewController!.reload();
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.open_in_browser),
//               onPressed: () async {
//                 if (_currentUrl.isNotEmpty) {
//                   await _webViewController?.loadUrl(
//                     urlRequest: URLRequest(url: WebUri(_currentUrl)),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             // Progress indicator
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               height: _isLoading ? 3.0 : 0,
//               child: LinearProgressIndicator(
//                 value: _progress,
//                 backgroundColor: Colors.grey[800],
//                 valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
//               ),
//             ),
            
//             // WebView
//             Expanded(
//               child: Stack(
//                 children: [
//                   InAppWebView(
//                     initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
//                     initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                         useShouldOverrideUrlLoading: true,
//                         mediaPlaybackRequiresUserGesture: false,
//                         javaScriptEnabled: true,
//                         cacheEnabled: true,
//                       ),
//                       android: AndroidInAppWebViewOptions(
//                         useHybridComposition: true,
//                         safeBrowsingEnabled: false, // Add this to avoid potential null string issues
//                       ),
//                       ios: IOSInAppWebViewOptions(
//                         allowsInlineMediaPlayback: true,
//                       ),
//                     ),
//                     onWebViewCreated: (controller) {
//                       _webViewController = controller;
//                     },
//                     onLoadStart: (controller, url) {
//                       if (url != null) {
//                         setState(() {
//                           _currentUrl = url.toString();
//                           _isLoading = true;
//                           _hasError = false;
//                         });
//                       }
//                     },
//                     onLoadStop: (controller, url) {
//                       if (url != null) {
//                         _updateNavigationCapabilities();
//                         controller.getTitle().then((title) {
//                           if (mounted && title != null && title.isNotEmpty) { // Add null and empty checks
//                             setState(() {
//                               _pageTitle = title;
//                               _isLoading = false;
//                             });
//                           } else if (mounted) {
//                             setState(() {
//                               _pageTitle = widget.title; // Use default title if null or empty
//                               _isLoading = false;
//                             });
//                           }
//                         });
//                       } else {
//                         setState(() {
//                           _isLoading = false;
//                         });
//                       }
//                     },
//                     onProgressChanged: (controller, progress) {
//                       if (mounted) {
//                         setState(() {
//                           _progress = progress / 100;
//                         });
//                       }
//                     },
//                     onLoadError: (controller, url, code, message) {
//                       if (mounted) {
//                         setState(() {
//                           _isLoading = false;
//                           _hasError = true;
//                           _errorMessage = "Error $code: ${message ?? 'Unknown error'}"; // Handle null message
//                         });
//                       }
//                     },
//                     onLoadHttpError: (controller, url, statusCode, description) {
//                       if (mounted) {
//                         setState(() {
//                           _isLoading = false;
//                           _hasError = true;
//                           _errorMessage = "HTTP Error $statusCode: ${description ?? 'Unknown error'}"; // Handle null description
//                         });
//                       }
//                     },
//                     onUpdateVisitedHistory: (controller, url, isReload) {
//                       // Handle nullable url properly
//                       if (url != null && mounted) {
//                         setState(() {
//                           _currentUrl = url.toString();
//                         });
//                       }
//                     },
//                   ),
                  
//                   // Error view
//                   if (_hasError)
//                     Container(
//                       color: Colors.white,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.error_outline,
//                               color: Colors.red,
//                               size: 60,
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               'Failed to load page',
//                               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                               child: Text(
//                                 _errorMessage,
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 setState(() {
//                                   _hasError = false;
//                                 });
//                                 _webViewController?.reload();
//                               },
//                               icon: const Icon(Icons.refresh),
//                               label: const Text('Try Again'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Theme.of(context).primaryColor,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
            
//             // Bottom navigation bar
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, -1),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios),
//                           onPressed: _canGoBack
//                               ? () {
//                                   _webViewController?.goBack();
//                                 }
//                               : null,
//                           color: _canGoBack ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward_ios),
//                           onPressed: _canGoForward
//                               ? () {
//                                   _webViewController?.goForward();
//                                 }
//                               : null,
//                           color: _canGoForward ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.home),
//                           onPressed: () {
//                             _webViewController?.loadUrl(
//                               urlRequest: URLRequest(url: WebUri(widget.initialUrl)),
//                             );
//                           },
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.share),
//                           onPressed: _currentUrl.isNotEmpty
//                               ? () {
//                                   // Implement share functionality
//                                   // You can use a share package here
//                                 }
//                               : null,
//                           color: _currentUrl.isNotEmpty ? Theme.of(context).primaryColor : Colors.grey,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebsiteViewScreen extends StatefulWidget {
  final String initialUrl;
  final String title;

  const WebsiteViewScreen({
    Key? key, 
    required this.initialUrl,
    this.title = 'Website',
  }) : super(key: key);

  @override
  State<WebsiteViewScreen> createState() => _WebsiteViewScreenState();
}

class _WebsiteViewScreenState extends State<WebsiteViewScreen> {
  InAppWebViewController? _webViewController;
  double _progress = 0;
  String _currentUrl = '';
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;
  String _pageTitle = '';
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.initialUrl;
    _pageTitle = widget.title;
  }

  Future<bool> _handleBackPressed() async {
    if (_webViewController != null && await _webViewController!.canGoBack()) {
      _webViewController!.goBack();
      return false;
    }
    return true;
  }

  void _updateNavigationCapabilities() async {
    if (_webViewController != null) {
      final backStatus = await _webViewController!.canGoBack();
      final forwardStatus = await _webViewController!.canGoForward();
      
      if (mounted) {
        setState(() {
          _canGoBack = backStatus;
          _canGoForward = forwardStatus;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _pageTitle.isNotEmpty ? _pageTitle : widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                _currentUrl,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[300],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                if (_webViewController != null && !_isLoading) {
                  _webViewController!.reload();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.open_in_browser),
              onPressed: () async {
                if (_currentUrl.isNotEmpty) {
                  await _webViewController?.loadUrl(
                    urlRequest: URLRequest(url: WebUri(_currentUrl)),
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isLoading ? 3.0 : 0,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            ),
            
            // WebView
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                        cacheEnabled: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                        safeBrowsingEnabled: false,
                        allowContentAccess: true,
                        allowFileAccess: true,
                        supportMultipleWindows: false,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      // Handle null values safely
                      final url = navigationAction.request.url;
                      if (url != null) {
                        // Update current URL safely
                        if (mounted) {
                          setState(() {
                            _currentUrl = url.toString();
                          });
                        }
                      }
                      
                      // Return null to let the WebView handle the URL
                      return null;
                    },
                    onLoadStart: (controller, url) {
                      if (url != null && mounted) {
                        setState(() {
                          _currentUrl = url.toString();
                          _isLoading = true;
                          _hasError = false;
                        });
                      }
                    },
                    onLoadStop: (controller, url) {
                      if (mounted) {
                        _updateNavigationCapabilities();
                        
                        if (url != null) {
                          setState(() {
                            _currentUrl = url.toString();
                          });
                        }
                        
                        controller.getTitle().then((title) {
                          if (mounted) {
                            setState(() {
                              _pageTitle = title ?? widget.title;
                              _isLoading = false;
                            });
                          }
                        }).catchError((error) {
                          if (mounted) {
                            setState(() {
                              _pageTitle = widget.title;
                              _isLoading = false;
                            });
                          }
                        });
                      }
                    },
                    onProgressChanged: (controller, progress) {
                      if (mounted) {
                        setState(() {
                          _progress = progress / 100;
                        });
                      }
                    },
                    onLoadError: (controller, url, code, message) {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                          _hasError = true;
                          _errorMessage = "Error $code: ${message ?? 'Unknown error'}";
                        });
                      }
                    },
                    onLoadHttpError: (controller, url, statusCode, description) {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                          _hasError = true;
                          _errorMessage = "HTTP Error $statusCode: ${description ?? 'Unknown error'}";
                        });
                      }
                    },
                    onUpdateVisitedHistory: (controller, url, isReload) {
                      if (url != null && mounted) {
                        setState(() {
                          _currentUrl = url.toString();
                        });
                      }
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      // Optional: handle console messages for debugging
                      debugPrint("Console: ${consoleMessage.message}");
                    },
                    onReceivedServerTrustAuthRequest: (controller, challenge) async {
                      // Accept all SSL certificates to handle potential SSL issues
                      return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                    },
                  ),
                  
                  // Error view
                  if (_hasError)
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load page',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                _errorMessage,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _hasError = false;
                                });
                                _webViewController?.reload();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Bottom navigation bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: _canGoBack
                              ? () {
                                  _webViewController?.goBack();
                                }
                              : null,
                          color: _canGoBack ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: _canGoForward
                              ? () {
                                  _webViewController?.goForward();
                                }
                              : null,
                          color: _canGoForward ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home),
                          onPressed: () {
                            _webViewController?.loadUrl(
                              urlRequest: URLRequest(url: WebUri(widget.initialUrl)),
                            );
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: _currentUrl.isNotEmpty
                              ? () {
                                  // Implement share functionality
                                  // You can use share_plus package:
                                  // Share.share(_currentUrl);
                                }
                              : null,
                          color: _currentUrl.isNotEmpty ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}