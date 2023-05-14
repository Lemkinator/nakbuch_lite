import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';

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
  late List<Hymn> _hymns;
  Function? disposeListen;

  @override
  void initState() {
    _hymns = getHymnsWithBuchId(getCurrentBuchId());
    disposeListen = listenToCurrentBuchId( (value) {
      setState(() {
        _hymns = getHymnsWithBuchId(getCurrentBuchId());
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ImplicitlyAnimatedList<Hymn>(
        // The current items in the list.
        items: _hymns,
        // Called by the DiffUtil to decide whether two object represent the same item.
        // For example, if your items have unique ids, this method should check their id equality.
        areItemsTheSame: (a, b) => a.nummer == b.nummer,
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
                    RouteStateScope.of(context).go('/${getCurrentBuchId()}/text/${item.nummer}');
                  },
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(index == 0 ? 16 : 0),
                    bottom: Radius.circular(index == _hymns.length - 1 ? 16 : 0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(120, 120, 120, 0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(index == 0 ? 16 : 0),
                        bottom: Radius.circular(index == _hymns.length - 1 ? 16 : 0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(item.getNummerAndTitle()),
                        ),
                        if (index != _hymns.length - 1)
                          const Divider(
                            height: 0.5,
                          ),
                      ],
                    ),
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
            child: Text(oldItem.getNummerAndTitle()),
          );
        },
      ),
    );
  }
}
