import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/WeatherViewModel.dart';
import 'view/HomeView.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
    );
  }
}
