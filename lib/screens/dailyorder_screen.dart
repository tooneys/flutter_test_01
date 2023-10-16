import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/models/order.dart';
import 'package:flutter_test_01/screens/error/data_not_found.dart';
import 'package:flutter_test_01/screens/error/something_wrong.dart';
import 'package:flutter_test_01/widgets/datatable_widget.dart';

class DailyOrderScreen extends StatefulWidget {
  const DailyOrderScreen({super.key});

  @override
  State<DailyOrderScreen> createState() => _DailyOrderScreenState();
}

class _DailyOrderScreenState extends State<DailyOrderScreen> {
  late Future<List<OrderAnanlys>> _dailyOrder;
  final _apiClient = ApiClient();

  @override
  void initState() {
    _dailyOrder = _apiClient.fetchSales();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '일별주문금액',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: FutureBuilder<List<OrderAnanlys>>(
          future: _dailyOrder,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const SomethingWrong();
            }

            if (snapshot.hasData) {
              final List<OrderAnanlys>? data = snapshot.data;

              if (data != null) {
                return DataTableWidget(data: data);
              }
            }

            return const DataNotFound();
          },
        ),
      ),
    );
  }
}
