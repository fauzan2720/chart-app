class IncomeModel {
  int? id;
  String? date;
  int? income;

  IncomeModel({this.id, this.date, this.income});

  IncomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    income = json['income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['income'] = income;
    return data;
  }
}
