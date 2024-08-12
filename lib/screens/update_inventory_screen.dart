import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';

class UpdateInventoryScreen extends StatefulWidget {
  const UpdateInventoryScreen({super.key});

  @override
  State<UpdateInventoryScreen> createState() => _UpdateInventoryScreenState();
}

class _UpdateInventoryScreenState extends State<UpdateInventoryScreen> {
  final searchController = TextEditingController();
  List<Product> products = [
    Product(name: 'Product A', sku: 'SKU001', isPurchased: true),
    Product(name: 'Product B', sku: 'SKU002', isPurchased: true),
    Product(name: 'Product C', sku: 'SKU003', isPurchased: false),
  ];

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Update Inventory Data',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Anek')),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const CommonDrawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: filterProducts,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductBlock(product: filteredProducts[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonElevatedButton(
                borderRadius: 30,
                width: double.infinity,
                height: kToolbarHeight - 10,
                text: 'SUBMIT',
                backgroundColor: const Color(0xff004791),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataSubmitSuccessfull(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String sku;
  final bool isPurchased;
  int? sale;
  int? inventory;
  String? liquidation;

  Product({
    required this.name,
    required this.sku,
    required this.isPurchased,
    this.sale,
    this.inventory,
    this.liquidation,
  });
}

class ProductBlock extends StatefulWidget {
  final Product product;

  const ProductBlock({super.key, required this.product});

  @override
  _ProductBlockState createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  final saleController = TextEditingController();
  final inventoryController = TextEditingController();
  final liquidationController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    saleController.text = widget.product.sale?.toString() ?? '';
    inventoryController.text = widget.product.inventory?.toString() ?? '';
    liquidationController.text = widget.product.liquidation ?? '';
  }

  void validateInput() {
    setState(() {
      if (saleController.text.isNotEmpty && inventoryController.text.isNotEmpty) {
        int sale = int.parse(saleController.text);
        int inventory = int.parse(inventoryController.text);
        if (inventory > sale) {
          errorMessage = 'Inventory should be less than or equal to sales';
        } else {
          errorMessage = null;
        }
      } else {
        errorMessage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: !widget.product.isPurchased?Colors.white54:Colors.white,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.name}',style: const TextStyle(fontSize: 16),),
            Text('SKU: ${widget.product.sku}',style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 8),
            TextField(
              controller: saleController,
              decoration: const InputDecoration(labelText: 'Sale'),
              keyboardType: TextInputType.number,
              enabled: widget.product.isPurchased,
              onChanged: (_) => validateInput(),
            ),
            TextField(
              controller: inventoryController,
              decoration: const InputDecoration(labelText: 'Inventory'),
              keyboardType: TextInputType.number,
              enabled: widget.product.isPurchased,
              onChanged: (_) => validateInput(),
            ),
            TextField(
              controller: liquidationController,
              decoration: const InputDecoration(labelText: 'Liquidation'),
              enabled: widget.product.isPurchased,
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}