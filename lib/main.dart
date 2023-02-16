import 'package:chart_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chart_app/models/income_model.dart';
import 'package:chart_app/controller/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:chart_app/controller/chart_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ChartAppPage(),
    );
  }
}

class _ChartAppPage extends StatefulWidget {
  const _ChartAppPage();

  @override
  State<_ChartAppPage> createState() => _ChartAppPageState();
}

class _ChartAppPageState extends State<_ChartAppPage> {
  int isSelectedIndex = 0;

  late TooltipBehavior tooltipBehavior;
  List<IncomeModel> incomeData = [];
  List<ChartData> chartData = [];

  @override
  void initState() {
    fetchAllIncomeData(incomeData: incomeData, chartData: chartData);
    tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget categories() {
      return Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              const SizedBox(
                width: 30.0,
              ),
              FozButton(
                index: 0,
                isSelectedIndex: isSelectedIndex,
                label: "7 Hari",
                onPressed: (index) {
                  isSelectedIndex = 0;
                  getAWeek(incomeData: incomeData, chartData: chartData);
                  setState(() {});
                },
              ),
              FozButton(
                index: 1,
                isSelectedIndex: isSelectedIndex,
                label: "1 Bulan",
                onPressed: (index) {
                  isSelectedIndex = 1;
                  getAMonth(incomeData: incomeData, chartData: chartData);
                  setState(() {});
                },
              ),
              FozButton(
                index: 2,
                isSelectedIndex: isSelectedIndex,
                label: "6 Bulan",
                onPressed: (index) {
                  isSelectedIndex = 2;
                  getHalfYear(incomeData: incomeData, chartData: chartData);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget boxGrafik() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[100],
        ),
        child: SfCartesianChart(
          title: ChartTitle(
              text: 'Grafik Pendapatan',
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 11.0,
              )),
          primaryXAxis: CategoryAxis(),
          tooltipBehavior: tooltipBehavior,
          series: <ChartSeries>[
            SplineSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => isSelectedIndex == 2
                  ? DateFormat('MMM yy').format(DateTime.parse(data.x))
                  : DateFormat('d MMM').format(DateTime.parse(data.x)),
              yValueMapper: (ChartData data, _) => data.y,
              animationDuration: 2000,
              color: Colors.black,
            ),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        height: 120.0,
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://dartpad.github.io/dart-192.png",
                  width: 44.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "syncfusion_flutter_charts: ^20.4.50",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://logos-world.net/wp-content/uploads/2020/11/GitHub-Symbol.png",
                  width: 64.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "github.com/fauzan2720/chart-app",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Chart App"),
        actions: [
          IconButton(
            onPressed: () {
              fetchAllIncomeData(incomeData: incomeData, chartData: chartData);
              isSelectedIndex = 0;
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              categories(),
              boxGrafik(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}
