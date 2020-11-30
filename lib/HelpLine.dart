import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpLine extends StatefulWidget {
  @override
  _HelpLineState createState() => _HelpLineState();
}

class _HelpLineState extends State<HelpLine> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://14.139.58.69/icar_teldir/teli_dir/home/search_contact',
    );
  }
}
