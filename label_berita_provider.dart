import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class labelberitaprovider with ChangeNotifier {
  List data = [];

  Future<List> muatdata() async {
    final url =
        "http://api.mediastack.com/v1/news?acces_key=780fbc89edc422258cba5ff898abe24c";
    final response = await get(Uri.parse(url)); //http.getG nya error
    if (response.statusCode != 200) {
      data = [];
    } else {
      final js = jsonDecode(response.body);
      data = js['data'];
    }
    notifyListeners();
    return data;
  }
}
