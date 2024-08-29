import 'package:cheminova/models/product_manual_model.dart';
import 'package:cheminova/provider/product_manual_provider.dart';
import 'package:cheminova/screens/view_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';

class ProductsManualScreen extends StatelessWidget {
  const ProductsManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the provider
    final productManualProvider =
        Provider.of<ProductManualProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productManualProvider.getProductManualList();
    });

    return CommonBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/Back_attendance.png'),
              padding: const EdgeInsets.only(right: 20),
            ),
          ],
          title: const Text(
            'Products Manual',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: 'Anek'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const CommonDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                Consumer<ProductManualProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (provider.productManualList.isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.all(20.0)
                          .copyWith(top: 30, bottom: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: const Color(0xffB4D1E5).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: provider.productManualList
                            .map(
                              (product) =>
                                  _buildProductButton(context, product),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductButton(BuildContext context, ProductManualModel product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CommonElevatedButton(
        borderRadius: 30,
        width: double.infinity,
        height: kToolbarHeight - 10,
        text: product.title,
        backgroundColor: const Color(0xff004791),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewPdfScreen(productManualModel: product),
          ),
        ),
      ),
    );
  }
}
