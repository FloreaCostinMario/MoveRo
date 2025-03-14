import 'package:flutter/material.dart';
import 'package:ro_transit_app/Utils/Operators.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  final Operator SelectedOperator;

  const WebView({super.key, required this.SelectedOperator});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              widget.SelectedOperator.ViewLink ?? "https://example.com",
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, "/home"),
          onLongPress:
              () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Inapoi la meniul principal")),
              ),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse(
                  widget.SelectedOperator.ViewLink ?? "https://example.com",
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            onLongPress:
                () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text("Deschide in browser")),
                ),
            icon: Icon(Icons.open_in_browser_rounded),
          ),
        ],
        title: Text(
          widget.SelectedOperator.Name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: "Bahnschrift",
            fontFamilyFallback: ["Helvetica", "Arial"],
          ),
        ),
      ),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
