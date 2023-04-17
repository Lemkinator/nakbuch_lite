import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

import '../data.dart';

bool _isLargeScreen(BuildContext context) => getWindowType(context) >= AdaptiveWindowType.large;

bool _isMediumScreen(BuildContext context) => getWindowType(context) == AdaptiveWindowType.medium;

class NavigationTrailing extends StatefulWidget {
  const NavigationTrailing({
    Key? key,
    required this.themeMode,
    required this.handleThemeModeChange,
    required this.buch,
    required this.handleBuchChange,
  }) : super(key: key);

  final ThemeMode themeMode;
  final void Function(ThemeMode?) handleThemeModeChange;
  final Buch buch;
  final void Function(Buch) handleBuchChange;

  @override
  State<NavigationTrailing> createState() => _NavigationTrailingState();
}

class _NavigationTrailingState extends State<NavigationTrailing> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: _isLargeScreen(context) ? _expandedTrailingActions() : _trailingActions(),
    ));
  }

  Widget _expandedTrailingActions() => Container(
        constraints: const BoxConstraints.tightFor(width: 250),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                widget.handleThemeModeChange(null);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text('Thema'),
                    Expanded(child: Container()),
                    widget.themeMode == ThemeMode.light
                        ? const Icon(Icons.light_mode_outlined)
                        : widget.themeMode == ThemeMode.dark
                            ? const Icon(Icons.dark_mode_outlined)
                            : const Icon(Icons.brightness_auto_outlined),
                  ],
                ),
              ),
            ),
            const Divider(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    widget.handleBuchChange(Buch.values[i]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        //colored text
                        widget.buch == Buch.values[i]
                            ? Text(Buch.values[i].name(), style: const TextStyle(color: nakbuchBlue))
                            : Text(Buch.values[i].name()),
                        Expanded(child: Container()),
                        widget.buch == Buch.values[i] ? const Icon(Icons.menu_book, color: nakbuchBlue) : const Icon(Icons.menu_book),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _trailingActions() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: _ThemeModeButton(
              themeMode: widget.themeMode,
              handleThemeModeChange: () => widget.handleThemeModeChange(null),
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: _BuchButton(
              buch: widget.buch,
              handleBuchChange: widget.handleBuchChange,
            ),
          ),
        ],
      );
}

List<Widget> appBarActions(
  BuildContext context,
  ThemeMode themeMode,
  void Function(ThemeMode?) handleThemeModeChange,
  Buch buch,
  void Function(Buch) handleBuchChange,
) {
  return !_isMediumScreen(context) && !_isLargeScreen(context)
      ? [
          _ThemeModeButton(
            themeMode: themeMode,
            handleThemeModeChange: () => handleThemeModeChange(null),
          ),
          _BuchButton(
            buch: buch,
            handleBuchChange: handleBuchChange,
          ),
        ]
      : [Container()];
}

class _ThemeModeButton extends StatelessWidget {
  const _ThemeModeButton({
    required this.handleThemeModeChange,
    required this.themeMode,
    this.showTooltipBelow = true,
  });

  final Function handleThemeModeChange;
  final ThemeMode themeMode;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Thema ändern',
      child: IconButton(
        icon: themeMode == ThemeMode.light
            ? const Icon(Icons.light_mode_outlined)
            : themeMode == ThemeMode.dark
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.brightness_auto_outlined),
        onPressed: () => handleThemeModeChange(),
      ),
    );
  }
}

class _BuchButton extends StatelessWidget {
  const _BuchButton({
    required this.buch,
    required this.handleBuchChange,
  });

  final Buch buch;
  final Function handleBuchChange;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.menu_book,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Buch auswählen',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(4, (index) {
          return PopupMenuItem(
            value: index,
            enabled: index != Buch.values.indexOf(buch),
            child: Wrap(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.menu_book),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(Buch.values[index].name()),
                ),
              ],
            ),
          );
        });
      },
      onSelected: (int index) => handleBuchChange(Buch.values[index]),
    );
  }
}
