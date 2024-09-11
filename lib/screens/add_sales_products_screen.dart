import 'package:cheminova/models/sales_task_response.dart';
import 'package:cheminova/provider/add_sales_provider.dart';
import 'package:cheminova/utils/string_extension.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddSalesProductScreen extends StatefulWidget {
  final String distributorType;
  final String tradeName;
  final String pdRdId;
  final String? inventoryId;

  const AddSalesProductScreen(
      {super.key,
      required this.distributorType,
      required this.tradeName,
      required this.pdRdId,
      this.inventoryId});

  @override
  State<AddSalesProductScreen> createState() => _AddSalesProductScreenState();
}

class _AddSalesProductScreenState extends State<AddSalesProductScreen> {
  final searchController = TextEditingController();
  late AddSalesProvider salesTaskProvider;
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    salesTaskProvider = Provider.of<AddSalesProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      salesTaskProvider.getTask();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      salesTaskProvider.resetProducts();
    }
    super.dispose();
  }

  datePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(
          () => dateController.text = DateFormat('dd/MM/yyyy').format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: CommonBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonAppBar(
              actions: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Image.asset('assets/Back_attendance.png'),
                    padding: const EdgeInsets.only(right: 20))
              ],
              title: Text(
                  '${widget.distributorType}\n${widget.tradeName.capitalize()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Anek')),
              backgroundColor: Colors.transparent,
              elevation: 0),
          drawer: const CommonDrawer(),
          bottomNavigationBar: Consumer<AddSalesProvider>(
            builder: (context, value, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: value.tasksList.isEmpty
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
                                        MediaQuery.of(context).size.height *
                                            0.9),
                                context: context,
                                builder: (BuildContext context) {
                                  return Consumer<AddSalesProvider>(
                                    builder: (context, value, child) =>
                                        StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: TextField(
                                                    controller:
                                                        searchController,
                                                    decoration: const InputDecoration(
                                                        labelText:
                                                            'Search by Name or SKU',
                                                        border:
                                                            OutlineInputBorder(),
                                                        prefixIcon:
                                                            Icon(Icons.search)),
                                                    onChanged: (val) {
                                                      value.filterProducts(val);
                                                      setState(() {});
                                                    })),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: searchController
                                                        .text.isEmpty
                                                    ? value.tasksList.length
                                                    : value.searchList.length,
                                                itemBuilder: (context, index) {
                                                  bool isAlreadySelected = value
                                                      .selectedProducts
                                                      .any((selectedProduct) =>
                                                          selectedProduct.SKU ==
                                                          value.tasksList[index]
                                                              .SKU);
                                                  final data = searchController
                                                          .text.isEmpty
                                                      ? value.tasksList[index]
                                                      : value.searchList[index];
                                                  return Card(
                                                    child: ListTile(
                                                      title: Text(
                                                          data.ProductName
                                                                  ?.capitalize() ??
                                                              '',
                                                          style: TextStyle(
                                                              color: isAlreadySelected
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black)),
                                                      subtitle: Text(
                                                          data.SKU ?? '',
                                                          style: TextStyle(
                                                              color: isAlreadySelected
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black)),
                                                      onTap: isAlreadySelected
                                                          ? null
                                                          : () {
                                                              setState(() => value
                                                                  .selectedProducts
                                                                  .add(data));
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ).whenComplete(() => setState(() {}));
                            },
                            backgroundColor: Colors.white,
                            icon: const Icon(Icons.add, color: Colors.black),
                            label: const Text('Add Products',
                                style: TextStyle(color: Colors.black))),
                        if (value.selectedProducts.isNotEmpty) ...[
                          const SizedBox(height: 16.0),
                          Consumer<AddSalesProvider>(
                            builder: (context, value, child) =>
                                CommonElevatedButton(
                              borderRadius: 30,
                              width: double.infinity,
                              height: kToolbarHeight - 10,
                              text: 'SUBMIT',
                              backgroundColor: const Color(0xff004791),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (value.selectedProducts.isNotEmpty &&
                                      value.selectedProducts.every((product) =>
                                          product.SKU!.isNotEmpty &&
                                          product.ProductName!.isNotEmpty &&
                                          product.SalesAmount != null &&
                                          product.QuantitySold != null)) {
                                    value.submitProducts(
                                        distributorType: widget.distributorType,
                                        pdRdId: widget.pdRdId,
                                        inventoryId: widget.inventoryId,
                                        date: dateController.text.trim(),
                                        tradeName: widget.tradeName);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please fill out all product details, including sale and inventory.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Consumer<AddSalesProvider>(
            builder: (context, value, child) {
              return Stack(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => datePicker(),
                        child: AbsorbPointer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: dateController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (value.selectedProducts.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.selectedProducts.length,
                            itemBuilder: (context, index) {
                              return ProductBlock(
                                  onUpdate: (updatedProduct) {
                                    setState(() {
                                      value.selectedProducts[index] =
                                          updatedProduct;
                                    });
                                  },
                                  onRemove: () {
                                    setState(() {
                                      value.selectedProducts.removeAt(index);
                                    });
                                  },
                                  product: value.selectedProducts[index]);
                            },
                          ),
                        )
                    ],
                  ),
                  (value.isLoading)
                      ? Container(
                          color: Colors.black12,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductBlock extends StatefulWidget {
  final SalesProduct product;
  final ValueChanged<SalesProduct> onUpdate;
  final VoidCallback onRemove;

  const ProductBlock({
    super.key,
    required this.product,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<ProductBlock> createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  final saleAmountController = TextEditingController();
  final quantitySoldController = TextEditingController();
  final commentController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    saleAmountController.text = (widget.product.SalesAmount ?? '').toString();
    commentController.text = (widget.product.comments ?? '').toString();
    quantitySoldController.text =
        (widget.product.QuantitySold ?? '').toString();
  }

  void validateInput() {
    setState(() {
      String? quantitySoldError;
      String? salesAmountError;

      if (saleAmountController.text.isEmpty) {
        quantitySoldError = 'Quantity sold cannot be empty.';
      }

      if (quantitySoldController.text.isEmpty) {
        salesAmountError = 'Sales amount cannot be empty.';
      }

      errorMessage = null;
      if (quantitySoldError == null && salesAmountError == null) {
        int quantitySold = int.parse(quantitySoldController.text);
        int salesAmount = int.parse(saleAmountController.text);
        String comments = commentController.text;

        widget.onUpdate(SalesProduct(
          SKU: widget.product.SKU,
          ProductName: widget.product.ProductName,
          QuantitySold: quantitySold,
          SalesAmount: salesAmount,
          comments: comments,
        ));
      } else {
        errorMessage = quantitySoldError ?? salesAmountError;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Product: ${widget.product.ProductName!.capitalize()}',
                  style: const TextStyle(fontSize: 16)),
              Text('SKU: ${widget.product.SKU}',
                  style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextField(
                    controller: saleAmountController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText: 'Sales amount',
                        errorText: saleAmountController.text.isEmpty
                            ? 'Sales amount cannot be empty.'
                            : null),
                    keyboardType: TextInputType.number,
                    enabled: true,
                    onChanged: (_) => validateInput()),
                TextField(
                    controller: quantitySoldController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText: 'Quantity sold',
                        errorText: quantitySoldController.text.isEmpty
                            ? 'Quantity sold cannot be empty.'
                            : null),
                    keyboardType: TextInputType.number,
                    enabled: true,
                    onChanged: (_) => validateInput()),
                TextField(
                    controller: commentController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      labelText: 'Comments',
                    ),
                    enabled: true,
                    onChanged: (_) => validateInput())
              ]),
            ]),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: const Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  ),
                  onPressed: widget.onRemove)),
        ],
      ),
    );
  }
}

class ProductModel {
  final String sku;
  final String productName;
  final int? sale;
  final int? inventory;
  final String? comments;
  final String? date;

  ProductModel({
    required this.sku,
    required this.productName,
    this.sale,
    this.inventory,
    this.comments,
    this.date,
  });
}
