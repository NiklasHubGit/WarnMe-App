import 'package:flutter/material.dart';
import 'package:warnapp/fcm.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAPI().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hochwasserwarn App'),
    );
  }
}

enum Alarm { nah, hq10, hq50, hq100, hqExtrem, mittel, experten, betreiber }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Alarm naehe = Alarm.nah;
  List<dynamic> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _getNaehe();
  }

  Future<void> _getNaehe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? naeheString = prefs.getString('naehe');
    if (naeheString == null) {
      setState(() {});
    } else if (naeheString == "nah") {
      setState(() {
        naehe = Alarm.nah;
      });
    } else if (naeheString == "hq10") {
      setState(() {
        naehe = Alarm.hq10;
      });
    } else if (naeheString == "hq50") {
      setState(() {
        naehe = Alarm.hq50;
      });
    } else if (naeheString == "hq100") {
      setState(() {
        naehe = Alarm.hq100;
      });
    } else if (naeheString == "hqExtrem") {
      setState(() {
        naehe = Alarm.hqExtrem;
      });
    } else if (naeheString == "experten") {
      setState(() {
        naehe = Alarm.experten;
      });
    } else if (naeheString == "betreiber") {
      setState(() {
        naehe = Alarm.betreiber;
      });
    }
  }

  Future<void> _setNaehe(naehe) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (naehe == Alarm.nah) {
      await prefs.setString("naehe", "nah");
    } else if (naehe == Alarm.hq10) {
      await prefs.setString("naehe", "hq10");
    } else if (naehe == Alarm.hq50) {
      await prefs.setString("naehe", "hq50");
    } else if (naehe == Alarm.hq100) {
      await prefs.setString("naehe", "hq100");
    } else if (naehe == Alarm.hqExtrem) {
      await prefs.setString("naehe", "hqExtrem");
    } else if (naehe == Alarm.experten) {
      await prefs.setString("naehe", "experten");
    } else if (naehe == Alarm.betreiber) {
      await prefs.setString("naehe", "betreiber");
    }
  }

  Future<void> _fetchData() async {
    const apiUrl = 'http://94.130.171.41:4243/data';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
          _isLoading = false;
          print(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Du wirst nun gewarnt, wenn das Wasser steigt.',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Ab welchem Hochwasser willst du gewarnt werden? ',
                    ),
                    TextSpan(
                      text: 'Hier',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url = Uri.parse(
                              'https://udo.lubw.baden-wuerttemberg.de/public/maps?repositoryItemGlobalId=.Wasser.Hochwasser%20und%20%C3%9Cberflutungsgefahr.Hochwassergefahrenkarten.HWGK_PUB_UDO_UF.mml');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                    ),
                    const TextSpan(
                      text: ' kannst du sehen, was das jeweils bedeutet.',
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                for (var alarm in [
                  [Alarm.nah, "Test / Demo"],
                  [Alarm.hq10, "HQ10"],
                  [Alarm.hq50, "HQ50"],
                  [Alarm.hq100, "HQ100"],
                  [Alarm.hqExtrem, "HQ-Extrem"],
                  [Alarm.experten, "Expertenkreis"],
                  [Alarm.betreiber, "Betreiber"],
                ])
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(alarm[1] as String),
                    leading: Radio<Alarm>(
                      groupValue: naehe,
                      value: alarm[0] as Alarm,
                      onChanged: (Alarm? value) {
                        setState(() {
                          naehe = value!;
                        });
                        _setNaehe(value);
                        FirebaseAPI().subscribe(value);
                      },
                    ),
                  ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          final item = _data[index];
                          final distance = item['distance'];
                          final receivedAt =
                              DateTime.parse(item['received_at']);
                          final average = item['average'];

                          return ListTile(
                            title: Text('Distanz: $distance'),
                            subtitle: Text('Durchschnitt: $average'),
                            trailing: Text(
                              'Received At: ${receivedAt.toLocal()}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
