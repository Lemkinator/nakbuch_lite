import 'package:flutter/material.dart';
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
  late Buch _buch;

  @override
  void initState() {
    _buch = getCurrentBuch();
    _pdfController = PdfController(
      document: PdfDocument.openData(getPDF(_buch.id)),
      initialPage: (getHymn(_buch.id, widget.nummer ?? 0)?.pdfPageIndex ?? 0) + 1,
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
          title: Text(_buch.title),
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