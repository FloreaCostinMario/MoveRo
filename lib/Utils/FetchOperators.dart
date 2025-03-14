import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

const _OperatorConfigURL = "https://example.com";

GetOperators() async {
  try {
    var file = await DefaultCacheManager().getSingleFile(_OperatorConfigURL);
    final Json = json.decode(utf8.decode(file.readAsBytesSync()));
    print(json);
    return Json;
  } catch (e) {
    Future.error(e);
  }
}
