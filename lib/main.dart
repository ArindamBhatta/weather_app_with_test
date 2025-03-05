import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_screen.dart';
import 'package:weather_app/repo/weather_repo.dart';

void main() {
  runApp(const MyApp());
  WeatherRepo.getWhetherInfo('london');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'whether App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}
