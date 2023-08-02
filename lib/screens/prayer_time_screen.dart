import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/prayer_time.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  PrayerTime time = PrayerTime();
  bool isLoading = false;
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getPrayerTime(String cityName) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response response = await http
          .get(Uri.parse("https://dailyprayer.abdulrcs.repl.co/api/$cityName"));
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          time = PrayerTime.fromJson(jsonDecode(response.body));
        });
      } else {
        // Handle API error or null data case
      }
    } catch (e) {
      // Handle network or other exceptions
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/bg.png")),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String cityName = cityController.text.trim();
                if (cityName.isNotEmpty) {
                  getPrayerTime(cityName);
                }
              },
              child: const Text('Get Prayer Time'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${time.city ?? ''}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${time.date ?? ''}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  _timeCard("Fajr", "${time.today?.fajr ?? 'N/A'}"),
                  _timeCard("Sunrise", "${time.today?.sunrise ?? 'N/A'}"),
                  _timeCard("Dhuhr", "${time.today?.dhuhr ?? 'N/A'}"),
                  _timeCard("Asr", "${time.today?.asr ?? 'N/A'}"),
                  _timeCard("Maghrib", "${time.today?.maghrib ?? 'N/A'}"),
                  _timeCard("Isha", "${time.today?.ishaA ?? 'N/A'}"),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _timeCard(String name, String time) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                color: Colors.white,
                size: 25,
              ),
              const SizedBox(height: 5),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
