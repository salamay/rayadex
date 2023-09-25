// To parse this JSON data, do
//
//     final xrpBalance = xrpBalanceFromJson(jsonString);

import 'dart:convert';

XrpBalance xrpBalanceFromJson(String str) => XrpBalance.fromJson(json.decode(str));

String xrpBalanceToJson(XrpBalance data) => json.encode(data.toJson());

class XrpBalance {
  List<Asset> assets;
  String balance;

  XrpBalance({
    required this.assets,
    required this.balance,
  });

  factory XrpBalance.fromJson(Map<String, dynamic> json) => XrpBalance(
    assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
    "balance": balance,
  };
}

class Asset {
  String balance;
  String currency;

  Asset({
    required this.balance,
    required this.currency,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    balance: json["balance"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "currency": currency,
  };
}
