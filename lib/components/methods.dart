import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> lunchInBrowser(String link) async {
  Uri url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.inAppWebView);
  } else {
    if (kDebugMode) {
      print("something went wrong");
    }
  }
}
