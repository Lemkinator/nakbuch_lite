import 'package:flutter/material.dart';
import 'dart:async';

import '../data.dart';
import '../routing.dart';
import '../widgets.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late RouteState _routeState;
  late List<Hymn> _lieder;
  late Buch _buch;
  String _input = '';
  String _nummerAndTitle = '';
  String _text = '';
  bool inputOngoing = false;
  Timer? _timer;
  Function? disposeListen;

  @override
  void initState() {
    _buch = getCurrentBuch();
    _lieder = getHymnsWithBuchId(_buch.id);
    _input = getCurrentNummer();
    _refreshView();
    disposeListen = listenToCurrentBuchId( (value) {
      setState(() {
        _buch = getCurrentBuch();
        _lieder = getHymnsWithBuchId(_buch.id);
        _refreshView();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    disposeListen?.call();
    super.dispose();
  }

  void _refreshView() {
    setState(() {
      final nummer = int.tryParse(_input);
      if (nummer != null && _buch.hymnExists(nummer)) {
        setCurrentNummer(_input);
        _nummerAndTitle = _lieder[nummer - 1].getNummerAndTitle();
        _text = _lieder[nummer - 1].text;
      } else {
        _nummerAndTitle = _input;
        _text = '';
      }
    });
  }

  void _startTimer() {
    inputOngoing = true;
    _stopTimer();
    _timer = Timer(const Duration(seconds: 4), () {
      inputOngoing = false;
    });
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void _onNumberButtonPressed(String number) {
    setState(() {
      if (!inputOngoing || _input.length > 2) {
        _input = '';
      }
      _input += number;
      _refreshView();
    });
    _startTimer();
  }

  void _onDeleteButtonPressed() {
    setState(() {
      if (_input.isNotEmpty) _input = _input.substring(0, _input.length - 1);
      _refreshView();
    });
    _startTimer();
  }

  void _onOkButtonPressed() {
    final nummer = int.tryParse(_input);
    if (nummer != null && _buch.hymnExists(nummer)) _routeState.go('/${_buch.id}/text/$nummer');
  }

  void _onPDFButtonPressed() {
    final nummer = int.tryParse(_input);
    if (nummer != null && _buch.hymnExists(nummer)) _routeState.go('/${_buch.id}/noten/$nummer');
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    _routeState = RouteStateScope.of(context);

    return ScreenLayout(childs: <Widget>[
      Text(
        _nummerAndTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: themeData.textTheme.headlineMedium?.copyWith(
          color: themeData.colorScheme.primary,
        ),
      ),
      smallSpace(),
      SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
              ],
            ),
            Row(
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
              ],
            ),
            Row(
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
              ],
            ),
            Row(
              children: [
                _buildDeleteButton(),
                _buildNumberButton('0'),
                _buildOkButton(),
                if (hasPDF(_buch.id)) _buildPDFButton(),
              ],
            ),
          ],
        ),
      ),
      mediumSpace(),
      p(themeData, _text),
      largeSpace(),
    ]);
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () => _onNumberButtonPressed(number),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            number,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () => _onDeleteButtonPressed(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Icon(
            Icons.backspace_outlined,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildOkButton() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () => _onOkButtonPressed(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Icon(Icons.check_circle_outline, size: 30),
        ),
      ),
    );
  }

  Widget _buildPDFButton() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        onPressed: () => _onPDFButtonPressed(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Icon(Icons.audio_file_outlined, size: 30),
        ),
      ),
    );
  }
}
