import 'package:cheminova/models/rejected_applicaton_response.dart';
import 'package:flutter/material.dart';
import 'package:cheminova/widgets/common_background.dart';
import 'package:cheminova/widgets/common_drawer.dart';
import 'package:cheminova/widgets/common_app_bar.dart';
import 'package:cheminova/widgets/common_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/rejected_provider.dart';

class RejectedApplicationScreen extends StatefulWidget {
  const RejectedApplicationScreen({super.key});

  @override
  State<RejectedApplicationScreen> createState() =>
      _RejectedApplicationScreenState();
}

class _RejectedApplicationScreenState extends State<RejectedApplicationScreen> {
  late RejectedProvider _rejectedProvider;

  @override
  void initState() {
    _rejectedProvider = RejectedProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _rejectedProvider,
        child: CommonBackground(
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
              title: const Text('Rejected Application',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Anek')),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            drawer: const CommonDrawer(),
            body: Consumer<RejectedProvider>(
              builder: (context, value, child) => value.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyListView(value: value),
            ),
          ),
        ));
  }
}

Widget buildProductButton(String productName) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: CommonElevatedButton(
      borderRadius: 30,
      width: double.infinity,
      height: kToolbarHeight - 10,
      text: productName,
      backgroundColor: const Color(0xff004791),
      onPressed: () {
        // Handle product button press
        debugPrint('$productName pressed');
      },
    ),
  );
}

class MyListView extends StatelessWidget {
  final RejectedProvider value;

  const MyListView({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: value.rejectedApplicationList.length,
      itemBuilder: (context, index) {
        RejectedApplicationResponse item = value.rejectedApplicationList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded corner
            child: ExpansionTile(
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              title: Text(
                item.tradeName ?? '',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((DateFormat("dd MMMM yyyy")
                      .format(DateTime.parse(item.createdAt ?? '')))),
                  Text("ID:${item.sId ?? ''}"),
                  for (var note in item.notes!) Text(note.message ?? ''),
                ],
              ),
              children: <Widget>[
                ListTile(
                  title: Text('Address: ${item.address ?? ''}'),
                ),
                ListTile(
                  title: Text('City: ${item.city ?? ''}'),
                ),
                ListTile(
                  title: Text('State: ${item.state ?? ''}'),
                ),
                ListTile(
                  title: Text('Pincode: ${item.pincode ?? ''}'),
                ),
                ListTile(
                  title: Text('Mobile: ${item.mobileNumber ?? ''}'),
                ),
                ListTile(
                  title: Text('Status: ${item.status ?? ''}'),
                ),
                ListTile(
                  title: Text(
                      'Principal Distributor: ${item.principalDistributer!.name ?? ''}'),
                ),
                ListTile(
                  title: Text('PAN Number: ${item.panNumber ?? ''}'),
                ),
                Image.network(item.panImg!.url ?? '', height: 250, width: 250),
                ListTile(
                  title: Text('Aadhar Number: ${item.aadharNumber ?? ''}'),
                ),
                Image.network(item.aadharImg?.url ?? '',
                    height: 250, width: 250),
                ListTile(
                  title: Text('GST Number: ${item.gstNumber ?? ''}'),
                ),
                Image.network(item.gstImg!.url ?? '', height: 250, width: 250),
                const ListTile(
                  title: Text('Pesticide License: '),
                ),
                if (item.pesticideLicenseImg != null)
                  Image.network(item.pesticideLicenseImg!.url ?? '',
                      height: 250, width: 250),
                const ListTile(
                  title: Text('selfieEntranceImg: '),
                ),
                Image.network(item.selfieEntranceImg!.url ?? '',
                    height: 250, width: 250),
                const ListTile(
                  title: Text('Notes:'),
                ),
                if (item.notes != null)
                  for (var note in item.notes!)
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 20),
                      title: Text(note.message ?? ''),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
