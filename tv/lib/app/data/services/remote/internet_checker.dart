import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const GOOGLE_DNS = '8.8.8.8';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) {
        final response = await http.get(Uri.parse(GOOGLE_DNS));

        return response.statusCode == HttpStatus.ok;
      } else {
        final lookup = await InternetAddress.lookup(GOOGLE_DNS);
        return (lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty);
      }
    } catch (e) {
      return false;
    }
  }
}
