// To parse this JSON data, do
//
//     final xrpTransactions = xrpTransactionsFromJson(jsonString);

import 'dart:convert';

XrpTransactions xrpTransactionsFromJson(String str) => XrpTransactions.fromJson(json.decode(str));

String xrpTransactionsToJson(XrpTransactions data) => json.encode(data.toJson());

class XrpTransactions {
  String? account;
  int? ledgerIndexMax;
  int? ledgerIndexMin;
  int? limit;
  List<Transaction> transactions;
  bool validated;

  XrpTransactions({
    required this.account,
    required this.ledgerIndexMax,
    required this.ledgerIndexMin,
    required this.limit,
    required this.transactions,
    required this.validated,
  });

  factory XrpTransactions.fromJson(Map<String, dynamic> json) => XrpTransactions(
    account: json["account"],
    ledgerIndexMax: json["ledger_index_max"],
    ledgerIndexMin: json["ledger_index_min"],
    limit: json["limit"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    validated: json["validated"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "ledger_index_max": ledgerIndexMax,
    "ledger_index_min": ledgerIndexMin,
    "limit": limit,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "validated": validated,
  };
}

class Transaction {
  Meta? meta;
  Tx tx;
  bool validated;

  Transaction({
    required this.meta,
    required this.tx,
    required this.validated,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    meta: Meta.fromJson(json["meta"]),
    tx: Tx.fromJson(json["tx"]),
    validated: json["validated"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta!.toJson(),
    "tx": tx.toJson(),
    "validated": validated,
  };
}

class Meta {
  List<AffectedNode> affectedNodes;
  int? transactionIndex;
  String? transactionResult;
  String? deliveredAmount;

  Meta({
    required this.affectedNodes,
    required this.transactionIndex,
    required this.transactionResult,
    required this.deliveredAmount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    affectedNodes: List<AffectedNode>.from(json["AffectedNodes"].map((x) => AffectedNode.fromJson(x))),
    transactionIndex: json["TransactionIndex"],
    transactionResult: json["TransactionResult"],
    deliveredAmount: json["delivered_amount"],
  );

  Map<String, dynamic> toJson() => {
    "AffectedNodes": List<dynamic>.from(affectedNodes.map((x) => x.toJson())),
    "TransactionIndex": transactionIndex,
    "TransactionResult": transactionResult,
    "delivered_amount": deliveredAmount,
  };
}

class AffectedNode {
  ModifiedNode? modifiedNode;
  CreatedNode? createdNode;

  AffectedNode({
    this.modifiedNode,
    this.createdNode,
  });

  factory AffectedNode.fromJson(Map<String, dynamic> json) => AffectedNode(
    modifiedNode: json["ModifiedNode"] == null ? null : ModifiedNode.fromJson(json["ModifiedNode"]),
    createdNode: json["CreatedNode"] == null ? null : CreatedNode.fromJson(json["CreatedNode"]),
  );

  Map<String, dynamic> toJson() => {
    "ModifiedNode": modifiedNode?.toJson(),
    "CreatedNode": createdNode?.toJson(),
  };
}

class CreatedNode {
  String? ledgerEntryType;
  String? ledgerIndex;
  NewFields? newFields;

  CreatedNode({
    required this.ledgerEntryType,
    required this.ledgerIndex,
    required this.newFields,
  });

  factory CreatedNode.fromJson(Map<String, dynamic> json) => CreatedNode(
    ledgerEntryType: json["LedgerEntryType"],
    ledgerIndex: json["LedgerIndex"],
    newFields: NewFields.fromJson(json["NewFields"]),
  );

  Map<String, dynamic> toJson() => {
    "LedgerEntryType": ledgerEntryType,
    "LedgerIndex": ledgerIndex,
    "NewFields": newFields!.toJson(),
  };
}

class NewFields {
  String? account;
  String? balance;
  int? sequence;

  NewFields({
    required this.account,
    required this.balance,
    required this.sequence,
  });

  factory NewFields.fromJson(Map<String, dynamic> json) => NewFields(
    account: json["Account"],
    balance: json["Balance"],
    sequence: json["Sequence"],
  );

  Map<String, dynamic> toJson() => {
    "Account": account,
    "Balance": balance,
    "Sequence": sequence,
  };
}

class ModifiedNode {
  FinalFields? finalFields;
  String? ledgerEntryType;
  String? ledgerIndex;
  PreviousFields? previousFields;
  String? previousTxnId;
  int? previousTxnLgrSeq;

  ModifiedNode({
    required this.finalFields,
    required this.ledgerEntryType,
    required this.ledgerIndex,
    required this.previousFields,
    required this.previousTxnId,
    required this.previousTxnLgrSeq,
  });

  factory ModifiedNode.fromJson(Map<String, dynamic> json) => ModifiedNode(
    finalFields: FinalFields.fromJson(json["FinalFields"]),
    ledgerEntryType: json["LedgerEntryType"],
    ledgerIndex: json["LedgerIndex"],
    previousFields: PreviousFields.fromJson(json["PreviousFields"]),
    previousTxnId: json["PreviousTxnID"],
    previousTxnLgrSeq: json["PreviousTxnLgrSeq"],
  );

  Map<String, dynamic> toJson() => {
    "FinalFields": finalFields!.toJson(),
    "LedgerEntryType": ledgerEntryType,
    "LedgerIndex": ledgerIndex,
    "PreviousFields": previousFields!.toJson(),
    "PreviousTxnID": previousTxnId,
    "PreviousTxnLgrSeq": previousTxnLgrSeq,
  };
}

class FinalFields {
  String? account;
  String? balance;
  int? flags;
  int? ownerCount;
  int? sequence;

  FinalFields({
    required this.account,
    required this.balance,
    required this.flags,
    required this.ownerCount,
    required this.sequence,
  });

  factory FinalFields.fromJson(Map<String, dynamic> json) => FinalFields(
    account: json["Account"],
    balance: json["Balance"],
    flags: json["Flags"],
    ownerCount: json["OwnerCount"],
    sequence: json["Sequence"],
  );

  Map<String, dynamic> toJson() => {
    "Account": account,
    "Balance": balance,
    "Flags": flags,
    "OwnerCount": ownerCount,
    "Sequence": sequence,
  };
}

class PreviousFields {
  String? balance;
  int? sequence;

  PreviousFields({
    required this.balance,
    this.sequence,
  });

  factory PreviousFields.fromJson(Map<String, dynamic> json) => PreviousFields(
    balance: json["Balance"],
    sequence: json["Sequence"],
  );

  Map<String, dynamic> toJson() => {
    "Balance": balance,
    "Sequence": sequence,
  };
}

class Tx {
  String? account;
  String? amount;
  String? destination;
  String? fee;
  List<MemoElement>? memos;
  int? sequence;
  String? signingPubKey;
  String? transactionType;
  String? txnSignature;
  int? date;
  String? hash;
  int? inLedger;
  int? ledgerIndex;
  int? flags;
  int? lastLedgerSequence;

  Tx({
    required this.account,
    required this.amount,
    required this.destination,
    required this.fee,
    this.memos,
    required this.sequence,
    required this.signingPubKey,
    required this.transactionType,
    required this.txnSignature,
    required this.date,
    required this.hash,
    required this.inLedger,
    required this.ledgerIndex,
    this.flags,
    this.lastLedgerSequence,
  });

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
    account: json["Account"],
    amount: json["Amount"],
    destination: json["Destination"],
    fee: json["Fee"],
    memos: json["Memos"] == null ? [] : List<MemoElement>.from(json["Memos"]!.map((x) => MemoElement.fromJson(x))),
    sequence: json["Sequence"],
    signingPubKey: json["SigningPubKey"],
    transactionType: json["TransactionType"],
    txnSignature: json["TxnSignature"],
    date: json["date"],
    hash: json["hash"],
    inLedger: json["inLedger"],
    ledgerIndex: json["ledger_index"],
    flags: json["Flags"],
    lastLedgerSequence: json["LastLedgerSequence"],
  );

  Map<String, dynamic> toJson() => {
    "Account": account,
    "Amount": amount,
    "Destination": destination,
    "Fee": fee,
    "Memos": memos == null ? [] : List<dynamic>.from(memos!.map((x) => x.toJson())),
    "Sequence": sequence,
    "SigningPubKey": signingPubKey,
    "TransactionType": transactionType,
    "TxnSignature": txnSignature,
    "date": date,
    "hash": hash,
    "inLedger": inLedger,
    "ledger_index": ledgerIndex,
    "Flags": flags,
    "LastLedgerSequence": lastLedgerSequence,
  };
}

class MemoElement {
  MemoMemo memo;

  MemoElement({
    required this.memo,
  });

  factory MemoElement.fromJson(Map<String, dynamic> json) => MemoElement(
    memo: MemoMemo.fromJson(json["Memo"]),
  );

  Map<String, dynamic> toJson() => {
    "Memo": memo.toJson(),
  };
}

class MemoMemo {
  String memoData;

  MemoMemo({
    required this.memoData,
  });

  factory MemoMemo.fromJson(Map<String, dynamic> json) => MemoMemo(
    memoData: json["MemoData"],
  );

  Map<String, dynamic> toJson() => {
    "MemoData": memoData,
  };
}
