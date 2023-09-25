import 'package:ryipay/component/AppEnum.dart';

class SupportedCoin{
  String? id;
  String? wallet_id;
  String asset_name;
  String? wallet_BIP44path;
  String? address_index;
  String? wallet_address;
  String? privateKey;
  String coinImage;
  String? coinGekoId;
  CoinType? coinType;
  String? abi;
  String? contractAddress;
  String? tokenSymbol;
  String? tokenChain;
  String? decimal;
  String? tokenType;
  String? tokenChainId;
  SupportedCoin({
    this.id,
    this.wallet_id,
    required this.asset_name,
    this.wallet_BIP44path,
    this.address_index,
    this.wallet_address,
    this.privateKey,
    required this.coinImage,
    this.coinGekoId,
    required this.coinType,
    this.abi,
    this.contractAddress,
    this.tokenSymbol,
    this.tokenChain,
    this.decimal,
    this.tokenType,
  this.tokenChainId
  });
}