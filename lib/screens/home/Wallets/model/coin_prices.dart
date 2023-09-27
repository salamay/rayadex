// To parse this JSON data, do
//
//     final currentPrices = currentPricesFromJson(jsonString);

import 'dart:convert';

CurrentPrices currentPricesFromJson(String str) => CurrentPrices.fromJson(json.decode(str));

String currentPricesToJson(CurrentPrices data) => json.encode(data.toJson());

class CurrentPrices {
  Ripple ripple;
  Bitcoin bitcoin;
  Bitcoin dogecoin;
  Bitcoin ethereum;

  CurrentPrices({
    required this.ripple,
    required this.bitcoin,
    required this.dogecoin,
    required this.ethereum,
  });

  factory CurrentPrices.fromJson(Map<String, dynamic> json) => CurrentPrices(
    ripple: Ripple.fromJson(json["ripple"]),
    bitcoin: Bitcoin.fromJson(json["bitcoin"]),
    dogecoin: Bitcoin.fromJson(json["dogecoin"]),
    ethereum: Bitcoin.fromJson(json["ethereum"]),
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
class Bitcoin {
  double usd;

  Bitcoin({
    required this.usd,
  });

  factory Bitcoin.fromJson(Map<String, dynamic> json) => Bitcoin(
    usd: json["usd"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "usd": usd,
  };
}
