import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/models/order.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/widgets/datatable_widget.dart';
import 'package:flutter_test_01/widgets/linechart_widget.dart';

class OrderAnalysisScreen extends StatefulWidget {
  const OrderAnalysisScreen({super.key});

  @override
  State<OrderAnalysisScreen> createState() => _OrderAnalysisScreenState();
}

class _OrderAnalysisScreenState extends State<OrderAnalysisScreen> {
  late Future<List<OrderAnanlys>> _orderAnanlys;
  final _apiClient = ApiClient();

  @override
  void initState() {
    _orderAnanlys = _apiClient.fetchSales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          '주문분석',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          margin: const EdgeInsets.only(top: 30),
          child: FutureBuilder<List<OrderAnanlys>>(
            future: _orderAnanlys,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                );
              }

              if (snapshot.hasData) {
                final List<OrderAnanlys>? orderData = snapshot.data;

                if (orderData != null) {
                  return Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: LineChartWidget(
                          data: orderData,
                        ),
                      ),
                      const Divider(height: 15),
                      Flexible(
                        child: DataTableWidget(
                          data: orderData,
                        ),
                      ),
                    ],
                  );
                }
              }

              return const Text(
                "No Data Found",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
