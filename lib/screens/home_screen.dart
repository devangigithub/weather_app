import 'package:api/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:api/model/modelweather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }
  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('last_searched_city') ?? 'New York';
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWeather(lastCity);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final List<String> weekDays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5394df),
              Color(0xFF5e9cd9),
              Color(0xFFacccec),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 16,right: 16),
          child: weatherProvider.weather == null
              ? Center(child: CircularProgressIndicator()) // Show a loading indicator
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchBar(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      weatherProvider.weather!.location.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${weatherProvider.weather!.currentWeather.tempC}°",
                              style: TextStyle(
                                fontSize: 75,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "${weatherProvider.weather!.location.region.toString()}",
                              style: TextStyle(
                                fontSize: 16  ,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "${weatherProvider.weather!.location.country.toString()}",
                              style: TextStyle(
                                fontSize: 16  ,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "${weatherProvider.weather!.currentWeather.lastUpdated.toString()}°",
                              style: TextStyle(
                                fontSize: 14  ,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Image.network(
                        'https://eu.community.samsung.com/t5/image/serverpage/image-id/2407289i3D98578AC5D4376C/image-dimensions/2000?v=v2&px=-1',
                        height: 280,
                        width: 160,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Feels like ${weatherProvider.weather!.currentWeather.feelslikeC}°",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade900.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("Wind km/h",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("Humidity",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center,),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("visibility",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.windKph}",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),textAlign: TextAlign.center
                            ),
                          ),
                        ), Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.humidity} %",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.visKm}",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("cloud",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("Gust km/h",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center,),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            child: Text("Wind direction",style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.cloud}",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),textAlign: TextAlign.center
                            ),
                          ),
                        ), Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.gustKph}",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text("${weatherProvider.weather!.currentWeather.windDir}",style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Generally clear. Highs 31 to 33°C and lows 17 to 19°C.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),

                          Divider(
                            color: Colors.grey.shade400,
                             thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              6,
                                  (index) => Column(
                                children: [
                                  Text("${10 + index}:30",style: TextStyle(color: Colors.white),),

                                  SizedBox(height: 10,),
                                  Icon(Icons.wb_sunny_sharp, size: 30, color: Colors.yellow),
                                  SizedBox(height: 10,),
                                  Text(
                                    "${28 + index}°",
                                    style: TextStyle(fontSize: 20,color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Weekly Weather Section
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          7,
                              (index) => Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  weekDays[index],
                                  style: TextStyle(color: Colors.white, fontSize: 20),

                                ),
                                Row(
                                  children: [
                                    Text("31° / 18°",style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 10),
                                    Icon(Icons.wb_sunny,
                                        color: Colors.yellow ,size: 30,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class WeatherStat extends StatelessWidget {
  final String title;
  final String value;

  const WeatherStat({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}


class SearchBar extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF5394df),
                Color(0xFF5e9cd9),
                Color(0xFFacccec),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue),
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      String cityName = controller.text.trim();
                      if (cityName.isNotEmpty) {
                        await Provider.of<WeatherProvider>(
                          context,
                          listen: false,
                        ).fetchWeather(cityName);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('last_searched_city', cityName);

                        Navigator.of(context).pop();
                      }
                    },
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
