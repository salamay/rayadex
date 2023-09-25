import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';


class Global{
  static final List<SupportedCoin> coins=[
    // SupportedCoin(asset_name: CoinName.Bitcoin.name, coinImage: "assets/icon/bitcoin.png", coinGekoId: 'bitcoin',wallet_BIP44path: "m/88'/0'/0'/0/0", coinType: CoinType.COIN),
    SupportedCoin(asset_name: CoinName.XRP.name, coinImage: "assets/icon/ethereum.png", coinGekoId: 'ripple',wallet_BIP44path: "m/44'/144'/0'/0/0",coinType: CoinType.COIN),
    // SupportedCoin(asset_name: CoinName.Doge.name, coinImage: "assets/icon/dogecoin.png", coinGekoId: 'dogecoin',wallet_BIP44path: "m/44'/3'/0'/0/0",coinType: CoinType.COIN),
  ];
}