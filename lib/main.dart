import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/WeatherViewModel.dart';
import 'view/HomeView.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
