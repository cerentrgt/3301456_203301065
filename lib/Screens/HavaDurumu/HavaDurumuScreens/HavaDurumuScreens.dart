
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memory_notebook/utils/weatherData.dart';

class HavaDurumuScreens extends StatefulWidget {

  final WeatherData weatherData;


  const HavaDurumuScreens({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<HavaDurumuScreens> createState() => _HavaDurumuScreensState();
}

class _HavaDurumuScreensState extends State<HavaDurumuScreens> {

  int? temperature;
  Icon? weatherDisplayIcon;
  AssetImage? backgroundImage;
  String? city;

  void updateDisplayInfo(WeatherData weatherData){

    setState(() {
      temperature=weatherData.currentTemperature!.round();
      city=weatherData.city;
      WeatherDisplayData displayData=weatherData.getWeatherDisplayData();
      backgroundImage=displayData.weatherImage;
      weatherDisplayIcon=displayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage!,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                child: weatherDisplayIcon,
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "$temperature°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    letterSpacing: -5,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "$city°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    letterSpacing: -5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
