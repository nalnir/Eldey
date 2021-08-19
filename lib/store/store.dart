import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Store extends InheritedWidget {

  Future<http.Response> fetch() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
  final List<Map> weather_data;
  
  const Store({ 
    required Widget child,
    required this.weather_data 
  }) : super(child: child);

  static List<Map> of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Store>()!.weather_data;

  @override
  bool updateShouldNotify(Store oldWidget) => weather_data.isNotEmpty;

  // static Store of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Store>();
}