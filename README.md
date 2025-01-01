# WarnMe
 Setup
1. Firebase-Konfigurationsdateien (google-services.json und GoogleService-Info.plist)

Die Dateien google-services.json (für Android) und GoogleService-Info.plist (für iOS) wurden aus Sicherheitsgründen nicht in dieses Repository aufgenommen. Sie enthalten projektbezogene Konfigurationsdetails, die spezifisch für dein Firebase-Projekt sind.

Um die App lokal zu starten, musst du diese Dateien selbst erstellen und in die entsprechenden Verzeichnisse einfügen.
2. Anleitung zum Abrufen der Konfigurationsdateien

    Firebase-Projekt erstellen:
        Gehe zu Firebase Console.
        Melde dich mit deinem Google-Konto an (oder erstelle ein neues Konto, falls nötig).
        Klicke auf "Projekt erstellen" und folge den Anweisungen.

    Android konfigurieren:
        Klicke in der Firebase-Konsole auf App hinzufügen > Android.
        Gib die Paket-ID ein, die in der android/app/build.gradle definiert ist (applicationId).
        Lade die Datei google-services.json herunter.
        Füge die Datei in das Verzeichnis android/app ein.

    iOS konfigurieren:
        Klicke in der Firebase-Konsole auf App hinzufügen > iOS.
        Gib die iOS-Bundle-ID ein, die in der ios/Runner.xcodeproj/project.pbxproj definiert ist.
        Lade die Datei GoogleService-Info.plist herunter.
        Füge die Datei in das Verzeichnis ios/Runner ein.

    Cloud Messaging aktivieren (optional):
        Falls du Firebase Cloud Messaging nutzt, aktiviere es in der Firebase-Konsole unter Build > Cloud Messaging.

3. Firebase-Dienste initialisieren

Stelle sicher, dass die Firebase-Dienste in deiner App korrekt initialisiert werden. Der folgende Code sollte sich in deiner main.dart befinden:

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

4. Hinweis für Entwickler

Falls du Schwierigkeiten beim Einrichten der Dateien hast, findest du weitere Details in der Firebase-Dokumentation.
