import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_ui/enums.dart';
import 'package:weather_ui/weather_api.dart';
import 'package:weather_ui/weather_model.dart';
import 'package:weather_ui/weather_widget.dart';

import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  List<String> images = ["nature.png", "bird.png"];

  List<String> weatherImages = ["windspeed.png", "humidity.png","rain.png"];

  late AnimationController _controller;
  late Animation<double> _animation;


  getImagePath(int index, List<String> lookUpList){
    return "assets/${lookUpList[index]}";
  }


  List<Color> lightBgColors1 = [
    Colors.white,
    Colors.lightBlue.shade100,
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade300,
  ];

  List<Color> lightBgColors2 = [
    Colors.white,
    Colors.grey.shade200,
    Colors.grey.shade500,
    Colors.grey.shade700,
  ];



  getLightBgColors(WeatherModel model){
    WeatherState weatherModel = model.weatherState;
    if(weatherModel==WeatherState.heavyRain || weatherModel == WeatherState.heavyCloud){
      return lightBgColors2;
    }
    else if (weatherModel==WeatherState.lightCloud || weatherModel == WeatherState.lightRain || weatherModel == WeatherState.clear){
      return lightBgColors1;
    }
  }

  getDisplayBoxColorOuter(WeatherModel model){
    WeatherState weatherModel = model.weatherState;
    if(weatherModel==WeatherState.heavyRain || weatherModel == WeatherState.heavyCloud){
      return lightBgColors2[2].withOpacity(0.8);
    }
    else if (weatherModel==WeatherState.lightCloud || weatherModel == WeatherState.lightRain || weatherModel == WeatherState.clear){
      return lightBgColors1[2].withOpacity(0.8);
    }
  }

  getDisplayBoxColorInner(WeatherModel model){
    WeatherState weatherModel = model.weatherState;
    if(weatherModel==WeatherState.heavyRain || weatherModel == WeatherState.heavyCloud){
      return lightBgColors2[3].withOpacity(0.5);
    }
    else if (weatherModel==WeatherState.lightCloud || weatherModel == WeatherState.lightRain || weatherModel == WeatherState.clear){
      return lightBgColors1[3].withOpacity(0.5);
    }
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    WeatherApi weatherApi = WeatherApi();
    
    return Scaffold(
      body : PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherApi.weatherList.length,
        itemBuilder : (_, mainIndex){
          
          return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: getLightBgColors(weatherApi.weatherList[mainIndex]),
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                            children:[

                              Positioned(child:
                              Container(
                                margin: const EdgeInsets.only(top:70, left : 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(weatherApi.getCityName(mainIndex), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),),
                                    SizedBox(
                                      width: 250,
                                      child: Text(weatherApi.getMessage(mainIndex), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400,color: Colors.lightBlue.shade900),
                                      ),),

                                  ],
                                ),
                              ),),
                              Positioned(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: -4, sigmaY: 10),
                                    child: Container(
                                      width: DisplaySize.getSize(context).width,
                                      height: 200,
                                      margin: const EdgeInsets.only(top: 180, left: 20,right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: getDisplayBoxColorOuter(weatherApi.weatherList[mainIndex]),
                                        boxShadow: [
                                          BoxShadow(
                                            color: getDisplayBoxColorInner(weatherApi.weatherList[mainIndex]),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 10), // changes position of shadow
                                          ),
                                        ],
                                        // color: Colors.lightBlue.shade100.withOpacity(0.4),

                                      ),
                                      child : Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: -35,
                                            right: 20,
                                            child: ScaleTransition(
                                              scale: _animation,
                                              child: SizedBox(
                                                width: 150,
                                                height: 150,
                                                child: Image.asset(weatherApi.getImageUrl(mainIndex)),
                                              ),
                                            )
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            right: 40,
                                            child:

                                            Text(weatherApi.weatherType(mainIndex), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),
                                          Positioned(
                                            top: 40,
                                            left: 60,
                                            child: Text(weatherApi.getTemperature(mainIndex), style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 30,
                                            left: 40,
                                            child: Text("${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),

                              Positioned(

                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX:0, sigmaY: 10),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 420, left: 20,right: 20),
                                    width: DisplaySize.getSize(context).width,
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: WeatherWidget(
                                                outer: getDisplayBoxColorOuter(weatherApi.weatherList[mainIndex]),
                                                inner: getDisplayBoxColorInner(weatherApi.weatherList[mainIndex]),
                                                weatherImage: getImagePath(0, weatherImages),
                                                weatherText:  weatherApi.getWindSpeed(mainIndex)),
                                            ),
                                        const Expanded(flex: 2,child: SizedBox(),),
                                        Expanded(
                                          flex: 3,
                                          child: WeatherWidget(
                                              outer: getDisplayBoxColorOuter(weatherApi.weatherList[mainIndex]),
                                              inner: getDisplayBoxColorInner(weatherApi.weatherList[mainIndex]),
                                              weatherImage: getImagePath(1, weatherImages),
                                              weatherText:  weatherApi.getHumidity(mainIndex)),
                                        ),
                                        const Expanded(flex: 2,child: SizedBox(),),
                                        Expanded(
                                          flex: 3,
                                          child: WeatherWidget(
                                              outer: getDisplayBoxColorOuter(weatherApi.weatherList[mainIndex]),
                                              inner: getDisplayBoxColorInner(weatherApi.weatherList[mainIndex]),
                                              weatherImage: getImagePath(2, weatherImages),
                                              weatherText:  weatherApi.getChanceOfRain(mainIndex)),
                                        ),



                                      ],
                                    ),
                                  ),
                                ),),



                              for (int i = 0; i < weatherApi.weatherList.length; i++)
                                Positioned(
                                  child: Container(
                                    alignment: Alignment(-0.6 + (i * 0.3),1.4-(i* 0.04)),
                                    child: Image.asset(getImagePath(1, images), fit: BoxFit.fill, width: 50, color: i==mainIndex?Colors.black: Colors.black45,),),
                                ),

                            ]


                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                        alignment: Alignment (-0.9, 1),
                        child: Image.asset(getImagePath(0, images), fit: BoxFit.fill,),)
                      ),


                    ],

                  ),
                );
        }
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

}




