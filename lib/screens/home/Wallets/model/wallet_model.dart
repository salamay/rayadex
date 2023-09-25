class WalletModel{
  String wallet_id;
  String wallet_name;
  String? mnemonic;
  String? privateKey;
  String walletType;
  WalletModel({required this.wallet_id,required this.wallet_name, this.mnemonic,this.privateKey,required this.walletType});
}