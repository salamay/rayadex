// To parse this JSON data, do
//
//     final currentPrices = currentPricesFromJson(jsonString);

import 'dart:convert';

CurrentPrices currentPricesFromJson(String str) => CurrentPrices.fromJson(json.decode(str));

String currentPricesToJson(CurrentPrices data) => json.encode(data.toJson());

class CurrentPrices {
  Ripple ripple;

  CurrentPrices({
    required this.ripple,
  });

  factory CurrentPrices.fromJson(Map<String, dynamic> json) => CurrentPrices(
    ripple: Ripple.fromJson(json["ripple"]),
  );

  Map<String, dynamic> toJson() => {
    "ripple": ripple.toJson(),
  };
}

class Ripple {
  double usd;

  Ripple({
    required this.usd,
  });

  factory Ripple.fromJson(Map<String, dynamic> json) => Ripple(
    usd: json["usd"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "usd": usd,
  };
}
