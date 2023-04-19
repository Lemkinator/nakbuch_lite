import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../data.dart';
import '../routing.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Function? disposeListen;
  List<Lied> _lieder = getLieder();

  @override
  void initState() {
    disposeListen = GetStorage().listenKey('buch', (value) {
      setState(() {
        _lieder = getLieder();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeListen?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedList<Lied>(
      // The current items in the list.
      items: _lieder,
      // Called by the DiffUtil to decide whether two object represent the same item.
      // For example, if your items have unique ids, this method should check their id equality.
      areItemsTheSame: (a, b) => a.number == b.number,
      // Called, as needed, to build list item widgets.
      // List items are only built when they're scrolled into view.
      itemBuilder: (context, animation, item, index) {
        // Specifiy a transition to be used by the ImplicitlyAnimatedList.
        // See the Transitions section on how to import this transition.
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: Center(
            child: SizedBox(
              width: 1000,
              child: InkWell(
                onTap: () {
                  RouteStateScope.of(context).go('${Buch.current().route()}/lied/${item.number}');
                },
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(index == 0 ? 16 : 0),
                  bottom: Radius.circular(index == _lieder.length - 1 ? 16 : 0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('${item.number}. ${item.title}'),
                ),
              ),
            ),
          ),
        );
      },
      // An optional builder when an item was removed from the list.
      // If not specified, the List uses the itemBuilder with
      // the animation reversed.
      removeItemBuilder: (context, animation, oldItem) {
        return FadeTransition(
          opacity: animation,
          child: Text('${oldItem.number}. ${oldItem.title}'),
        );
      },
    );
  }
}
