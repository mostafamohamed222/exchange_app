class ExchangeModel{
  final num rate;
  final String day;

  const ExchangeModel({
    this.rate = 0,
    this.day = '',
  });

    factory ExchangeModel.fromJson(double rate , String day) => ExchangeModel(
        rate: rate ,
        day: day ,
      );

  Map<String, dynamic> toJson() => {
        "description": rate,
        "code": day,
      };
}