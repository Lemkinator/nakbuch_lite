import 'dart:async';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';

import '../data.dart';
import '../widgets.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late ConfettiController _controllerCenter;
  int versionPressedCounter = 0;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Stack(
      children: <Widget>[
        ScreenLayout(
          childs: [
            Center(
              child: ElevatedButton(
                onPressed: _versionPressed,
                child: const Text("Version: 1.0.0"),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/Lemkinator/nakbuch_lite'));
                },
                child: const Text("Source Code"),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://www.leonard-lemke.com'));
                },
                child: const Text("Über mich"),
              ),
            ),
            largeSpace(),
            h2(themeData, "Hilfe"),
            smallSpace(),
            p(themeData,
                "Diese App steht in keiner Verbindung zur Neuapostolischen Kirche oder der Verlag Friedrich Bischoff GmbH und beinhaltet lediglich die urheberrechtsfreien Texte aus dem folgenden Büchern:"),
            smallSpace(),
            li(themeData, "Gesangbuch (320 von 438 Liedern)"),
            li(themeData, "Chorbuch (206 von 462 Liedern)"),
            li(themeData, "Jugendliederbuch (41 von 102 Liedern)"),
            li(themeData, "Ergänzungsheft zum Jugendliederbuch (3 von 20 Liedern)"),
            mediumSpace(),
            p(themeData,
                "Bei den restlichen Liedern liegen die Rechte noch bei den Urhebern, weshalb diese nicht oder nur teilweise angezeigt werden können."),
            p(themeData,
                "Die Informationen zum Urheberrecht wurden mit großer Sorgfalt geprüft, wenn mir hierbei unwissend Fehler unterlaufen sind, bitte ich freundlichst um einen Hinweis, dem ich unverzüglich nachgehen werde."),
            mediumSpace(),
            p(themeData,
                "Die Verwaltung der Rechte obliegt u.a. der Verlag Friedrich Bischoff GmbH, welche selbst eine (kostenpflichtige) App für das Gesangbuch und eine (kostenpflichtige) App für das Chorbuch herausgegeben hat."),
            largeSpace(),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            //emissionFrequency: 0.05, // how often it should emit
            numberOfParticles: 50, // number of particles to emit
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  _versionPressed() {
    setState(() {
      versionPressedCounter++;
    });

    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        versionPressedCounter = 0;
      });
    });

    if (versionPressedCounter >= 10) {
      setState(() {
        versionPressedCounter = 0;
      });
      print("confetti");
      _controllerCenter.play();
      //when the controller stops, open the file picker
      _controllerCenter.addListener(() {
        if (_controllerCenter.state == ConfettiControllerState.stopped) {
          _controllerCenter.removeListener(() {});
          _openFilePicker();
        }
      });
    }
  }

  _openFilePicker() async {
    print("Picker: ");
    FilePicker filePicker = kIsWeb ? FilePickerWeb.platform : FilePicker.platform;
    var result = await filePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['zip', 'json'],
    );
    if (result != null) {
      Buch? buch;
      for (var file in result.files) {
        if (file.name.startsWith("hymnsGesangbuch")) {
          buch = Buch.gesangbuch;
        } else if (file.name.startsWith("hymnsChorbuch")) {
          buch = Buch.chorbuch;
        } else if (file.name.startsWith("hymnsJugendliederbuch")) {
          buch = Buch.jugendliederbuch;
        } else if (file.name.startsWith("hymnsJBErgaenzungsheft")) {
          buch = Buch.jbergaenzungsheft;
        }
        if (buch != null) {
          var bytes = file.bytes;
          var content = utf8.decode(bytes!);
        }
      }
    } else {
      // User canceled the picker
    }
  }
}
