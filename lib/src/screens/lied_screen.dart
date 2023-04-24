import 'package:get_storage/get_storage.dart';
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
  late List<Lied> _lieder;
  late int _nummer;
  late int _index;
  late bool _isFavorite;
  late LiquidController liquidController;

  @override
  void initState() {
    liquidController = LiquidController();
    _lieder = getLieder(Buch.current());
    _nummer = widget.nummer;
    _index = widget.nummer < 1 || widget.nummer > _lieder.length ? 0 : _nummer - 1;
    _isFavorite = GetStorage('data').read('favorites_${Buch.current().path()}_$_nummer') ?? false;
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
          _isFavorite = GetStorage('data').read('favorites_${Buch.current().path()}_$_nummer') ?? false;
        });
        //RouteStateScope.of(context).go('${Buch.current().route()}/text/${page + 1}');
      },
      liquidController: liquidController,
      initialPage: _index,
      waveType: WaveType.circularReveal,
      pages: <Widget>[
        for (var i = 0; i < _lieder.length; i++)
          ScreenLayout(title: Buch.current().name(), actions: [
            IconButton(
              icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_outline),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                  GetStorage('data').write('favorites_${Buch.current().path()}_$_nummer', _isFavorite);
                });
              },
            ),
            if (hasPDF(Buch.current()))
              IconButton(
                icon: const Icon(Icons.audio_file_outlined),
                onPressed: () {
                  RouteStateScope.of(context).go('${Buch.current().route()}/noten/$_nummer');
                },
              ),
          ], childs: <Widget>[
            h3(themeData, _lieder[i].numberAndTitle()),
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
