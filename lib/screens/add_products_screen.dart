import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/models/product_model.dart';
import 'package:cheminova/provider/product_provider.dart';
import 'package:cheminova/screens/data_submit_successfull.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {
  final PdRdResponseModel distributor;
  final String distributorType;
  const AddProductsScreen({
    super.key,
    required this.distributor,
    required this.distributorType,
  });

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  List<Product> filteredProducts = [];
  final searchController = TextEditingController();
  late ProductProvider provider;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.getProducts();
    setState(() {
      provider.selectedProducts.clear();
      filteredProducts = provider.productList;
    });
  }

  void filterProducts(String query) {
    setState(() {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      filteredProducts = provider.productList.where((product) {
        final productNameLower = product.name.toLowerCase();
        final productSkuLower = product.SKU.toLowerCase();
        final searchLower = query.toLowerCase();

        return productNameLower.contains(searchLower) ||
            productSkuLower.contains(searchLower);
      }).toList();
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
          title: Text(
            widget.distributor.name!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: 'Anek',
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const CommonDrawer(),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                Column(
                  children: [
                    if (provider.selectedProducts.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.selectedProducts.length,
                          itemBuilder: (context, index) {
                            return ProductBlock(index: index);
                          },
                        ),
                      ),
                  ],
                ),
                Align(
                  alignment: provider.selectedProducts.isEmpty
                      ? Alignment.center
                      : Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.9,
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Consumer<ProductProvider>(
                                  builder: (context, value, child) =>
                                      StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextField(
                                              controller: searchController,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Search by name or SKU',
                                                border: OutlineInputBorder(),
                                                prefixIcon: Icon(Icons.search),
                                              ),
                                              onChanged: (value) {
                                                filterProducts(value);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  filteredProducts.length,
                                              itemBuilder: (context, index) {
                                                bool isAlreadySelected =
                                                    provider.selectedProducts
                                                        .contains(
                                                            filteredProducts[
                                                                index]);
                                                return Card(
                                                  child: ListTile(
                                                    title: Text(
                                                      filteredProducts[index]
                                                          .name,
                                                      style: TextStyle(
                                                        color: isAlreadySelected
                                                            ? Colors.grey
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      filteredProducts[index]
                                                          .SKU,
                                                      style: TextStyle(
                                                        color: isAlreadySelected
                                                            ? Colors.grey
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    onTap: isAlreadySelected
                                                        ? null
                                                        : () {
                                                            setState(() {
                                                              provider
                                                                  .selectedProducts
                                                                  .add(filteredProducts[
                                                                      index]);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ).whenComplete(() {
                              setState(() {});
                            });
                          },
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.add, color: Colors.black),
                          label: const Text(
                            'Add Products',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        if (provider.selectedProducts.isNotEmpty) ...[
                          const SizedBox(height: 16.0),
                          CommonElevatedButton(
                            borderRadius: 30,
                            width: double.infinity,
                            height: kToolbarHeight - 10,
                            text: 'SUBMIT',
                            backgroundColor: const Color(0xff004791),
                            onPressed: () {
                              provider
                                  .submitSelectedProducts(
                                      "PrincipalDistributor",
                                      widget.distributor.id!)
                                  .then((value) {
                                if (value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DataSubmitSuccessfull(),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductBlock extends StatefulWidget {
  final int index;

  const ProductBlock({super.key, required this.index});

  @override
  _ProductBlockState createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  final saleController = TextEditingController();
  final inventoryController = TextEditingController();
  String? errorMessage;
  late ProductProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context, listen: false);
  }

  bool validateInput() {
    setState(() {
      if (saleController.text.isNotEmpty &&
          inventoryController.text.isNotEmpty) {
        // Check if both inputs are valid integers
        try {
          int sale = int.parse(saleController.text);
          int inventory = int.parse(inventoryController.text);

          // Validation: inventory should be less than or equal to sales
          if (inventory > sale) {
            errorMessage = 'Inventory should be less than or equal to sales';
          } else {
            errorMessage = null;
          }
        } catch (e) {
          // Handle the case where input is not a valid integer
          errorMessage = 'Please enter valid integer values for both fields';
        }
      } else {
        errorMessage = null;
      }
    });
    return errorMessage == null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: !widget.product.isPurchased ? Colors.white54 : Colors.white,
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${provider.selectedProducts[widget.index].name}',
                style: const TextStyle(fontSize: 16)),
            Text('SKU: ${provider.selectedProducts[widget.index].SKU}',
                style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 8),
            TextField(
              controller: saleController,
              decoration: const InputDecoration(labelText: 'Sale'),
              keyboardType: TextInputType.number,
              // enabled: widget.product.isPurchased,
              enabled: true,
              onChanged: (_) => validateInput()
                  ? provider.selectedProducts[widget.index].sale =
                      int.parse(saleController.text)
                  : null,
            ),
            TextField(
              controller: inventoryController,
              decoration: const InputDecoration(labelText: 'Inventory'),
              keyboardType: TextInputType.number,
              // enabled: widget.product.isPurchased,
              enabled: true,
              onChanged: (_) => validateInput()
                  ? provider.selectedProducts[widget.index].inventory =
                      int.parse(inventoryController.text)
                  : null,
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
