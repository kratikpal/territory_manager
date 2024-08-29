import 'package:cheminova/models/product_manual_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfScreen extends StatefulWidget {
  final ProductManualModel productManualModel;
  const ViewPdfScreen({super.key, required this.productManualModel});

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfPdfViewer.network(
          widget.productManualModel.productManualDetail.url,
        ),
      ),
    );
  }
}
