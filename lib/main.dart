import 'package:flutter/material.dart';
import 'package:warnapp/fcm.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  // This widget is the root of your application.
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

enum Alarm { nah, mittel, fern }

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
      setState(() {
      });
    } else if (naeheString == "nah") {
      setState(() {
        naehe = Alarm.nah;
      });
    } else if (naeheString == "mittel") {
      setState(() {
        naehe = Alarm.mittel;
      });
    }
  }

  Future<void> _setNaehe(naehe) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (naehe == Alarm.nah) {
      await prefs.setString("naehe", "nah");
    } else if (naehe == Alarm.mittel) {
      await prefs.setString("naehe", "mittel");
    }
  }

  Future<void> _fetchData() async {
    const apiUrl =
        'http://94.130.171.41:4243/data'; // Ersetze durch deine API-URL

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
      body: Column(
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "Wie nah bist du am Bach?(dies wirkt sich darauf aus wie früh du eine Benachrichtigung bekommst)"),
          ),
          Column(
            children: [
              ListTile(
                title: const Text("sehr nah am Bach"),
                leading: Radio<Alarm>(
                  groupValue: naehe,
                  value: Alarm.nah,
                  onChanged: (Alarm? value) {
                    setState(() {
                      naehe = value!;
                    });
                    _setNaehe(value);
                    FirebaseAPI().subscribe(value);
                  },
                ),
              ),
              ListTile(
                title: const Text("weiter weg"),
                leading: Radio<Alarm>(
                  groupValue: naehe,
                  value: Alarm.mittel,
                  onChanged: (Alarm? value) {
                    setState(() {
                      naehe = value!;
                    });
                    _setNaehe(value);
                    FirebaseAPI().subscribe(Alarm.mittel);
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
                        final receivedAt = DateTime.parse(item['received_at']);
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
    );
  }
}
