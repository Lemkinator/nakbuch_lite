import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets.dart';

class LiedScreen extends StatefulWidget {
  const LiedScreen({
    super.key,
    required this.nummer,
  });

  final int nummer;

  @override
  State<LiedScreen> createState() => _LiedScreenState();
}

class _LiedScreenState extends State<LiedScreen> {
  late List<Hymn> _lieder;
  late Buch _buch;
  late int _nummer;
  late int _index;
  late LiquidController liquidController;

  @override
  void initState() {
    liquidController = LiquidController();
    _lieder = getHymnsWithBuchId(getCurrentBuchId());
    _buch = getCurrentBuch();
    _nummer = widget.nummer;
    _index = widget.nummer < 1 || widget.nummer > _lieder.length ? 0 : _nummer - 1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LiquidSwipe(
      onPageChangeCallback: (page) {
        setState(() {
          _nummer = page + 1;
        });
        //RouteStateScope.of(context).go('/${_buch.id}/text/${page + 1}');
      },
      enableLoop: false,
      liquidController: liquidController,
      initialPage: _index,
      waveType: WaveType.circularReveal,
      pages: <Widget>[
        for (var i = 0; i < _lieder.length; i++)
          ScreenLayout(title: _buch.title, actions: [
            if (hasPDF(_buch.id))
              IconButton(
                icon: const Icon(Icons.audio_file_outlined),
                onPressed: () {
                  RouteStateScope.of(context).go('/${_buch.id}/noten/$_nummer');
                },
              ),
          ], childs: <Widget>[
            h3(themeData, _lieder[i].getNummerAndTitle()),
            mediumSpace(),
            p(themeData, _lieder[i].text),
            largeSpace(),
            p(themeData, _lieder[i].copyright),
            largeSpace(),
          ])
      ],
    );
  }
}
