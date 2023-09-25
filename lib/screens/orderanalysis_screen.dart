import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/models/order.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/widgets/datatable_widget.dart';
import 'package:flutter_test_01/widgets/linechart_widget.dart';
import 'package:gap/gap.dart';

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Text(
                "주문분석",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                          const Gap(15),
                          Expanded(
                            child: DataTableWidget(
                              data: orderData,
                            ),
                          ),
                        ],
                      );
                    }
                  }

                  return Text(
                    "No Data Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('뒤로'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
