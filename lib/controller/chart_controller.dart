import 'package:chart_app/data/dummy_data.dart';
import 'package:chart_app/models/income_model.dart';
import 'package:chart_app/controller/chart_data.dart';
import 'package:intl/intl.dart';

Future<List<IncomeModel>> fetchAllIncomeData({
  required List<IncomeModel> incomeData,
  required List<ChartData> chartData,
}) async {
  incomeData.clear();
  for (var item in DummyData.salesData) {
    incomeData.add(IncomeModel.fromJson(item));
  }

  getAWeek(
    incomeData: incomeData,
    chartData: chartData,
  );

  return incomeData;
}

List<ChartData> getAWeek({
  required List<IncomeModel> incomeData,
  required List<ChartData> chartData,
}) {
  chartData.clear();
  incomeData.sort((b, a) => a.date!.compareTo(b.date!));

  incomeData.map((item) {
    String isTitle = item.date!;
    int isValue = item.income!;

    var targetIndex = chartData.indexWhere((element) => element.x == isTitle);

    isChartData(String date) {
      if (chartData.indexWhere((element) => element.x == date) == -1) {
        return false;
      } else {
        return true;
      }
    }

    if (!isChartData(isTitle)) {
      chartData.add(
        ChartData(isTitle, isValue),
      );
    } else {
      chartData[targetIndex] = ChartData(
        isTitle,
        (chartData[targetIndex].y + isValue),
      );
    }
  }).toList();

  if (chartData.length > 7) {
    chartData.length = 7;
  }

  chartData.sort((a, b) => a.x.compareTo(b.x));

  return chartData;
}

List<ChartData> getAMonth({
  required List<IncomeModel> incomeData,
  required List<ChartData> chartData,
}) {
  chartData.clear();
  incomeData.sort((b, a) => a.date!.compareTo(b.date!));

  incomeData.map((item) {
    String isTitle = item.date!;
    int isValue = item.income!;

    var targetIndex = chartData.indexWhere((element) => element.x == isTitle);

    isChartData(String date) {
      if (chartData.indexWhere((element) => element.x == date) == -1) {
        return false;
      } else {
        return true;
      }
    }

    if (DateFormat('yyyy-MM').format(DateTime.parse(isTitle)) ==
        DateFormat('yyyy-MM').format(DateTime.now())) {
      if (!isChartData(isTitle)) {
        chartData.add(
          ChartData(isTitle, isValue),
        );
      } else {
        chartData[targetIndex] = ChartData(
          isTitle,
          (chartData[targetIndex].y + isValue),
        );
      }
    }
  }).toList();

  chartData.sort((a, b) => a.x.compareTo(b.x));

  return chartData;
}

List<ChartData> getHalfYear({
  required List<IncomeModel> incomeData,
  required List<ChartData> chartData,
}) {
  chartData.clear();
  incomeData.sort((b, a) => a.date!.compareTo(b.date!));

  incomeData.map((item) {
    String isTitle = item.date!;
    int isValue = item.income!;

    var targetIndex = chartData.indexWhere((element) =>
        DateFormat("MMM yy").format(DateTime.parse(element.x)) ==
        DateFormat("MMM yy").format(DateTime.parse(isTitle)));

    isChartData(String date) {
      if (chartData.indexWhere((element) =>
              DateFormat("MMM yy").format(DateTime.parse(element.x)) ==
              DateFormat("MMM yy").format(DateTime.parse(date))) ==
          -1) {
        return false;
      } else {
        return true;
      }
    }

    if (!isChartData(isTitle)) {
      chartData.add(
        ChartData(isTitle, isValue),
      );
    } else {
      chartData[targetIndex] = ChartData(
        isTitle,
        (chartData[targetIndex].y + isValue),
      );
    }
  }).toList();

  if (chartData.length > 6) {
    chartData.length = 6;
  }

  chartData.sort((b, a) => b.x.compareTo(a.x));

  return chartData;
}
