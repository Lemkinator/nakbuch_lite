import 'package:flutter/material.dart';
import 'package:nakbuch_lite/src/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../routing.dart';
import '../widgets.dart';

class NumberScreen extends StatefulWidget {
  final int? number;

  const NumberScreen({
    super.key,
    this.number,
  });

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  String _enteredNumber = "";
  String _numberAndTitle = "";
  String _text = "";
  Timer? _timer;
  bool inputOngoing = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late RouteState _routeState;
  late Buch buch;
  late Future<List<Lied>> _lieder;

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
    _lieder.then((List<Lied> lieder) {
      var number = int.tryParse(_enteredNumber);
      if (number != null && number > 0 && number <= lieder.length) {
        var index = number - 1;
        _numberAndTitle = lieder[index].numberAndTitle();
        _text = lieder[index].text;
      } else {
        _enteredNumber = "";
        _numberAndTitle = "";
        _text = "";
      }
      _prefs.then((SharedPreferences prefs) {
        prefs.setString('number', _enteredNumber);
      });
    });
  }

  void _onNumberButtonPressed(String number) {
    setState(() {
      if (!inputOngoing) {
        _enteredNumber = "";
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
    _lieder.then((List<Lied> lieder) {
      var number = int.tryParse(_enteredNumber);
      if (number != null && number > 0 && number <= lieder.length) {
        _routeState.go('${buch.route()}/lied/$number');
      } else {
        _enteredNumber = "";
        _numberAndTitle = "";
        _text = "";
      }
    });
  }

  @override
  void initState() {
    _prefs.then((SharedPreferences prefs) {
      _enteredNumber = prefs.getString('number') ?? "";
      _refreshView();
    });
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    _routeState = RouteStateScope.of(context);
    buch = buchFromRoute(_routeState.route.path);
    _lieder = getLieder(buch, _prefs);
    _prefs.then((SharedPreferences prefs) {
      _enteredNumber = prefs.getString('number') ?? "";
      _refreshView();
    });

    return ScreenLayout(childs: <Widget>[
      h2(themeData, _numberAndTitle),
      const SizedBox(height: 10),
      SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                _buildNumberButton("1"),
                _buildNumberButton("2"),
                _buildNumberButton("3"),
              ],
            ),
            Row(
              children: [
                _buildNumberButton("4"),
                _buildNumberButton("5"),
                _buildNumberButton("6"),
              ],
            ),
            Row(
              children: [
                _buildNumberButton("7"),
                _buildNumberButton("8"),
                _buildNumberButton("9"),
              ],
            ),
            Row(
              children: [
                _buildDeleteButton(),
                _buildNumberButton("0"),
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
