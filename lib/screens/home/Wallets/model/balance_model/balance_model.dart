// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
  String? incoming;
  String? outgoing;
  String? incomingPending;
  String? outgoingPending;
  double? totalBalance;
  BalanceModel({
    this.incoming,
    this.outgoing,
    this.incomingPending,
    this.outgoingPending,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    incoming: json["incoming"],
    outgoing: json["outgoing"],
    incomingPending: json["incomingPending"],
    outgoingPending: json["outgoingPending"],
  );

  Map<String, dynamic> toJson() => {
    "incoming": incoming,
    "outgoing": outgoing,
    "incomingPending": incomingPending,
    "outgoingPending": outgoingPending,
  };
}
