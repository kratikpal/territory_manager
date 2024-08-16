import 'package:cheminova/models/pd_rd_response_model.dart';
import 'package:cheminova/provider/pd_rd_provider.dart';
import 'package:cheminova/screens/add_products_screen.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateInventoryScreen extends StatefulWidget {
  const UpdateInventoryScreen({super.key});

  @override
  State<UpdateInventoryScreen> createState() => _UpdateInventoryScreenState();
}

class _UpdateInventoryScreenState extends State<UpdateInventoryScreen> {
  String? selectedDistributorType;
  PdRdResponseModel? selectedDistributor;

  @override
  void initState() {
    super.initState();
    // Fetch the PdRd data when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PdRdProvider>(context, listen: false);
      provider.getPdRd();
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
          title: const Text(
            'Update Inventory Data',
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CommonElevatedButton(
            borderRadius: 30,
            width: double.infinity,
            height: kToolbarHeight - 10,
            text: 'SUBMIT',
            backgroundColor: const Color(0xff004791),
            onPressed: () {
              if(selectedDistributor == null || selectedDistributorType == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select distributor type and distributor')),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductsScreen(
                      distributor: selectedDistributor!,
                      distributorType: selectedDistributorType!,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        body: Consumer<PdRdProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.pdRdList.isEmpty) {
              return const Center(child: Text('No distributors available.'));
            }

            List<PdRdResponseModel> principalDistributors = provider.pdRdList
                .where((item) => item.userType == 'SalesCoOrdinator')
                .toList();

            List<PdRdResponseModel> retailerDistributors = provider.pdRdList
                .where((item) => item.userType != 'SalesCoOrdinator')
                .toList();

            return Stack(
              children: [
                Column(
                  children: [
                    // Dropdown for selecting distributor type
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 25),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Distributor Type',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                        value: selectedDistributorType,
                        items: ['Principal Distributor', 'Retailer Distributor']
                            .map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistributorType = value;
                            selectedDistributor =
                                null; // Reset distributor selection when type changes
                          });
                        },
                      ),
                    ),
                    // Dropdown for selecting distributor name based on type
                    if (selectedDistributorType != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25),
                        child: DropdownButtonFormField<PdRdResponseModel>(
                          decoration: const InputDecoration(
                            labelText: 'Select Distributor Name',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                          value: selectedDistributor,
                          items: (selectedDistributorType ==
                                      'Principal Distributor'
                                  ? principalDistributors
                                  : retailerDistributors)
                              .map((PdRdResponseModel distributor) {
                            return DropdownMenuItem<PdRdResponseModel>(
                              value: distributor,
                              child: Text(distributor.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDistributor = value;
                            });
                          },
                          isExpanded: true,
                          isDense: true,
                          iconSize: 24,
                          hint: Text(
                              'Please select a ${selectedDistributorType ?? "Distributor Type"} first'),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
