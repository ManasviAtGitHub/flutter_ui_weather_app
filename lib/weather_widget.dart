import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.outer, required this.inner, required this.weatherImage, required this.weatherText});
  final Color outer, inner;
  final String weatherImage;
  final String weatherText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: outer,
        boxShadow: [
          BoxShadow(
            color: inner,
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(weatherImage, width: 50, height: 50),
          const SizedBox(height: 10,),
          Text(weatherText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}