import 'dart:async';
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:confetti/confetti.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';

import '../widgets.dart';
import '../data.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class InfoGridItem extends StatelessWidget {
  const InfoGridItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          onTap: () => onTap,
          child: Stack(
            children: [
              //add icon
              Positioned(
                right: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: icon,
                ),
              ),
              //add gradient
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              //add text
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      //white text
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
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
              child: IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://play.google.com/store/apps/details?id=de.lemke.nakbuch&gl=DE&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'),
                    );
                  },
                  icon: Image.asset(
                    'images/google-play-badge-de.png',
                    width: 200,
                  )),
            ),
            Center(
              child: ElevatedAutoLoadingButton(
                onPressed: () async {
                  await _openFilePicker();
                },
                child: const Text('Importieren'),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedAutoLoadingButton(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: const Text('Zurücksetzen'),
                      content: const Text('Importierte Inhalte löschen und Texte zurücksetzen?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Abbrechen'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text('Zurücksetzen'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setDefaultNAKBuch();
                            deleteAllPDFs();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Zurücksetzen'),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/Lemkinator/nakbuch_lite'));
                },
                child: const Text('Source Code'),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=de.lemke.nakbuch'));
                },
                child: const Text('Android App'),
              ),
            ),
            smallSpace(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://www.leonard-lemke.com'));
                },
                child: const Text('Über mich'),
              ),
            ),
            largeSpace(),
            h2(themeData, 'Hilfe'),
            smallSpace(),
            p(themeData,
                'Diese App steht in keiner Verbindung zur Neuapostolischen Kirche oder der Verlag Friedrich Bischoff GmbH und beinhaltet lediglich die urheberrechtsfreien Texte aus dem folgenden Büchern:'),
            smallSpace(),
            li(themeData, 'Gesangbuch (321 von 438 Liedern)'),
            li(themeData, 'Chorbuch (208 von 462 Liedern)'),
            li(themeData, 'Jugendliederbuch (42 von 102 Liedern)'),
            li(themeData, 'Ergänzungsheft zum Jugendliederbuch (3 von 20 Liedern)'),
            li(themeData, 'Lieder zum Glauben 2 (7 von 20 Liedern)'),
            //li(themeData, 'Chorliedersammlung 2 (41 von 159 Liedern)'),
            mediumSpace(),
            p(themeData,
                'Bei den restlichen Liedern liegen die Rechte noch bei den Urhebern, weshalb diese nicht oder nur teilweise angezeigt werden können.'),
            p(themeData,
                'Die Informationen zum Urheberrecht wurden mit großer Sorgfalt geprüft, wenn mir hierbei unwissend Fehler unterlaufen sind, bitte ich freundlichst um einen Hinweis, dem ich unverzüglich nachgehen werde.'),
            mediumSpace(),
            p(themeData,
                'Die Verwaltung der Rechte obliegt u.a. der Verlag Friedrich Bischoff GmbH, welche selbst eine (kostenpflichtige) App für das Gesangbuch und eine (kostenpflichtige) App für das Chorbuch herausgegeben hat.'),
            largeSpace(),
            largeSpace(),
            h1(themeData, 'Impressum'),
            smallSpace(),
            p(themeData, 'Leonard Lemke'),
            mediumSpace(),
            h3(themeData, 'Kontakt'),
            smallSpace(),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                p(themeData, 'E-Mail: '),
                TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse('mailto:nakbuch-lite@leonard-lemke.com'));
                  },
                  child: const Text('nakbuch-lite@leonard-lemke.com'),
                )
              ],
            ),
            mediumSpace(),
            h2(themeData, 'Haftungsausschluss'),
            smallSpace(),
            h3(themeData, 'Haftung für Inhalte'),
            smallSpace(),
            p(themeData,
                'Die Inhalte unserer Seiten wurden mit größter Sorgfalt erstellt. Für die Richtigkeit, Vollständigkeit und Aktualität der Inhalte können wir jedoch keine Gewähr übernehmen. Wir sind nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.'),
            smallSpace(),
            h3(themeData, 'Haftung für Links'),
            smallSpace(),
            p(themeData,
                'Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.'),
            smallSpace(),
            h3(themeData, 'Urheberrecht'),
            smallSpace(),
            p(themeData,
                'Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.'),
            smallSpace(),
            h3(themeData, 'Datenschutz'),
            smallSpace(),
            p(themeData,
                'Die Nutzung unserer Webseite ist in der Regel ohne Angabe personenbezogener Daten möglich. Soweit auf unseren Seiten personenbezogene Daten (beispielsweise Name, Anschrift oder eMail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche Zustimmung nicht an Dritte weitergegeben.'),
            smallSpace(),
            p(themeData,
                'Wir weisen darauf hin, dass die Datenübertragung im Internet (z.B. bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann. Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist nicht möglich.'),
            smallSpace(),
            p(themeData,
                'Der Nutzung von im Rahmen der Impressumspflicht veröffentlichten Kontaktdaten durch Dritte zur Übersendung von nicht ausdrücklich angeforderter Werbung und Informationsmaterialien wird hiermit ausdrücklich widersprochen. Die Betreiber der Seiten behalten sich ausdrücklich rechtliche Schritte im Falle der unverlangten Zusendung von Werbeinformationen, etwa durch Spam-Mails, vor.'),
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

  _openFilePicker() async {
    FilePicker filePicker = kIsWeb ? FilePickerWeb.platform : FilePicker.platform;
    var result = await filePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['zip', 'json', 'pdf'],
    );
    if (result != null) {
      for (var file in result.files) {
        if (file.extension == 'json') {
          processJSON(file.name, file.bytes!);
        } else if (file.extension == 'pdf') {
          processPDF(file.name, file.bytes!);
        } else if (file.extension == 'zip') {
          processZIP(file);
        }
      }
    }
  }

  processZIP(PlatformFile file) {
    var bytes = file.bytes;
    var zip = ZipDecoder().decodeBytes(bytes!);
    for (var file in zip.files) {
      var fileName = file.name;
      if (fileName.endsWith('.json')) {
        processJSON(fileName, file.content);
      } else if (fileName.endsWith('.pdf')) {
        processPDF(fileName, file.content);
      }
    }
  }

  processJSON(String fileName, Uint8List bytes) {
    var content = utf8.decode(bytes);
    try {
      var nakbuch = NAKBuch.fromJson(jsonDecode(content));
      setNAKBuch(nakbuch);
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  processPDF(String fileName, Uint8List bytes) {
    var box = Hive.box('pdf');
    box.put(fileName.replaceAll('.pdf', ''), bytes);
  }
}
