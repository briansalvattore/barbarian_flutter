import 'dart:convert' show json;

import 'package:flutter/material.dart';

typedef CustomDecoder = dynamic Function(dynamic output);

abstract class BarbarianBase {
  //Future<BarbarianBase> init({bool force});

  @protected
  String getString(String key);

  @protected
  Future<bool> setString(String key, String value);

  dynamic read(
    String key, {
    CustomDecoder customDecoder,
    dynamic defaultValue,
  }) {
    String first = getString(key);

    if (first == null) return null;

    final parts = first.split('__type__');
    String type = parts[0];
    String value = parts[1];

    switch (type) {
      case 'Null':
        return null;
      case 'String':
        return value;
      case 'int':
        return int.tryParse(value) ?? defaultValue;
      case 'double':
        return double.tryParse(value) ?? defaultValue;
      case 'bool':
        return value == 'true';
      default:
        try {
          return customDecoder(json.decode(value)) ?? defaultValue;
        } //
        catch (e) {
          return defaultValue ?? null;
        }
    }
  }

  void write(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
      case int:
      case double:
      case bool:
        setString(
          key,
          '${value.runtimeType}__type__$value',
        );
        break;
      default:
        setString(
          key,
          '${value.runtimeType}__type__${json.encode(value)}',
        );
        break;
    }
  }

  void delete(String key);

  List<String> getAllKeys();

  bool contains(String key);

  void dispose();

  @Deprecated(
    'Use `dispose` instead. '
    'This feature was deprecated after v0.3.0.',
  )
  void destroy() => dispose();
}
