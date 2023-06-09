import 'package:flutter/material.dart';

import '../widgets.dart';

class ScreenLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? backgroundImage;
  final double maxWidth;
  final List<Widget>? actions;
  final List<Widget> childs;

  const ScreenLayout({
    Key? key,
    this.title,
    this.subtitle,
    this.backgroundImage,
    this.maxWidth = 1000,
    this.actions,
    required this.childs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null && backgroundImage == null
          ? AppBar(
              title: Text(title!),
              actions: actions,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      body: CustomScrollView(
        slivers: [
          if (title != null && backgroundImage != null)
            SliverBanner(
              title: title!,
              subtitle: subtitle,
              backgroundImage: backgroundImage!,
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: childs,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
