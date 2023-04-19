import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
  String _enteredNumber = '';
  String _numberAndTitle = '';
  String _text = '';
  Timer? _timer;
  bool inputOngoing = false;
  Function? disposeListen;

  late RouteState _routeState;
  final Buch buch = Buch.current();
  List<Lied> _lieder = getLieder();

  void _startTimer() {
    inputOngoing = true;
    _stopTimer();
    _timer = Timer(const Duration(seconds: 3), () {
      inputOngoing = false;
    });
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void _refreshView() {
    var number = int.tryParse(_enteredNumber);
    if (number != null && number > 0 && number <= _lieder.length) {
      var index = number - 1;
      _numberAndTitle = _lieder[index].numberAndTitle();
      _text = _lieder[index].text;
    } else {
      _enteredNumber = '';
      _numberAndTitle = '';
      _text = '';
    }
    GetStorage().write('number', _enteredNumber);
  }

  void _onNumberButtonPressed(String number) {
    setState(() {
      if (!inputOngoing) {
        _enteredNumber = ' ';
      }
      _enteredNumber += number;
      _numberAndTitle = _enteredNumber;
      _refreshView();
    });
    _startTimer();
  }

  void _onDeleteButtonPressed() {
    setState(() {
      if (_enteredNumber.isNotEmpty) _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1);
      _numberAndTitle = _enteredNumber;
      _refreshView();
    });
    _startTimer();
  }

  void _onOkButtonPressed() {
    var number = int.tryParse(_enteredNumber);
    if (number != null && number > 0 && number <= _lieder.length) {
      _routeState.go('${buch.route()}/lied/$number');
    } else {
      _enteredNumber = '';
      _numberAndTitle = '';
      _text = '';
    }
  }

  @override
  void initState() {
    _enteredNumber = GetStorage().read('number') ?? '';
    _refreshView();

    disposeListen = GetStorage().listenKey('buch', (value) {
      _lieder = getLieder();
      _refreshView();
    });
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    disposeListen?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    _routeState = RouteStateScope.of(context);

    return ScreenLayout(childs: <Widget>[
      h2(themeData, _numberAndTitle),
      const SizedBox(height: 10),
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
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      p(themeData, _text),
      const SizedBox(height: 40),
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
}
