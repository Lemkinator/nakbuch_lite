import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pdfx/pdfx.dart';

import '../data.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({
    super.key,
    this.nummer,
  });

  final int? nummer;

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openData(Hive.box('pdf').get(Buch.current().path())),
      initialPage: (getPDFPageNumbers(Buch.current(), widget.nummer).firstOrNull ?? 0) + 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Buch.current().name()),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                _pdfController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _pdfController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              },
            ),
          ],
        ),
        body: PdfView(
          builders: PdfViewBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
            pageLoaderBuilder: (_) => const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, error) => Center(child: Text(error.toString())),
          ),
          controller: _pdfController,
        ));
  }
}
