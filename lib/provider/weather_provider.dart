import 'dart:convert';
import 'package:api/model/modelweather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;
  Future<void> fetchWeather(String text) async {
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=df08ef1012764017bdc90419240802&q=$text&aqi=no');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _weather = Weather.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}