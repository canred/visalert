import 'dart:convert';
import 'package:flutter/services.dart';

class ConfigService {
  static final ConfigService _instance = ConfigService._internal();
  factory ConfigService() => _instance;
  ConfigService._internal();

  Map<String, dynamic>? _config;

  Future<void> load() async {
    final configString = await rootBundle.loadString('assets/config.json');
    _config = json.decode(configString);
  }

  String getString(String key, {String defaultValue = ''}) {
    return _config != null && _config![key] != null
        ? _config![key].toString()
        : defaultValue;
  }

  dynamic get(String key) {
    return _config != null ? _config![key] : null;
  }

  Map<String, dynamic>? get all => _config;
}
