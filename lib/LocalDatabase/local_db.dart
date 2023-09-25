import 'dart:developer';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/home/Wallets/model/wallet_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  //118
  final int dbVersion=214;
  final String tableSupportedCoins="supportedcoins";
  final String wallet_id="wallet_id";
  final String wallet_name="wallet_name";
  final String asset_name="asset_name";
  final String wallet_BIP44path="wallet_BIP44path";
  final String address_index="address_index";
  final String wallet_address="wallet_address";
  final String privateKey="privateKey";
  final String coinGekoId="coinGekoId";
  final String coinImage="coinImage";
  final String abiCode="abiCode";
  final String contractAddress="contractAddress";
  final String tokenSymbol="tokenSymbol";
  final String tokenType="tokenType";
  final String tokenChain="tokenChain";
  final String tokenChainId="tokenChainId";
  final String decimal="decimal";

  final String id="id";
  final String tableWallet="wallets";
  final String mnemonic="mnemonic";
  final String walletType="walletType";
  final String coinType="coinType";



  Future<String> getDbPath() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    return databasesPath;
  }

  Future<String> initDB(databasesPath) async {
    try {
      String path = databasesPath + "/ryipay.db";
      return path;
    } catch (e) {
      log(e.toString());
      throw Exception("Unable to init database");
    }
  }

  Future<Database> getDatabase() async {
    String path = await getDbPath();
    String databasepath = await initDB(path);
    return openDb(databasepath);
  }

  Future<Database> openDb(String path) async {
    try {
      // open the database
      Database database =
      await openDatabase(path, version: dbVersion, onCreate: onCreateDB, onUpgrade: (Database db, int newVer, int oldVer) async {
            await db.execute('DROP TABLE IF EXISTS $tableSupportedCoins');
            await db.execute('DROP TABLE IF EXISTS $tableWallet');
            await onCreateDB(db, newVer);
          });
      return database;
    } catch (e) {
      log(e.toString());
      throw Exception("Unable to open database");
    }
  }

  Future<void> closeDb(Database database) async {
    database.close();
  }

  Future<void> onCreateDB(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE IF NOT EXISTS $tableSupportedCoins($id TEXT PRIMARY KEY,$wallet_id TEXT, $asset_name TEXT,$wallet_BIP44path TEXT,$address_index TEXT,$wallet_address TEXT,$privateKey TEXT,$coinImage TEXT,$coinGekoId TEXT,$coinType TEXT,$abiCode TEXT,$contractAddress TEXT,$tokenSymbol TEXT,$tokenChain TEXT,$decimal TEXT,$tokenType TEXT,$tokenChainId TEXT)');
    await db.execute('CREATE TABLE IF NOT EXISTS $tableWallet($wallet_id TEXT PRIMARY KEY, $wallet_name TEXT,$mnemonic TEXT,$privateKey TEXT,$walletType TEXT)');
  }

  Future<void> saveWallet(WalletModel walletModel)async{
    log("Saving wallet");
    Database database = await getDatabase();
    try {
      int id1;
      // Insert some records in a transaction
      await database.transaction((txn) async {
        id1 = await txn.rawUpdate(
            'replace into $tableWallet($wallet_id,$wallet_name,$mnemonic,$privateKey,$walletType) values (?,?,?,?,?)',
            [
              walletModel.wallet_id,walletModel.wallet_name,walletModel.mnemonic,
              walletModel.privateKey,walletModel.walletType
            ]);
        log("Wallet saved: $id1");
      });
    } catch (e) {
      log(e.toString());
      throw Exception("Unable save wallet");
    }
  }

  Future<void> saveCoin(SupportedCoin supportedCoin)async{
    log("Saving coin");
    Database database = await getDatabase();
    try {
      int id1;
      // Insert some records in a transaction
      await database.transaction((txn) async {
        id1 = await txn.rawUpdate(
            'replace into $tableSupportedCoins($id,$wallet_id,$asset_name,$wallet_BIP44path,$address_index,$wallet_address,$privateKey,$coinImage,$coinGekoId,$coinType,$abiCode,$contractAddress,$tokenSymbol,$tokenChain,$decimal,$tokenType,$tokenChainId) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
            [
              supportedCoin.id,supportedCoin.wallet_id,supportedCoin.asset_name,supportedCoin.wallet_BIP44path,
              supportedCoin.address_index,supportedCoin.wallet_address,supportedCoin.privateKey,
              supportedCoin.coinImage,supportedCoin.coinGekoId,supportedCoin.coinType!.name,
              supportedCoin.abi,supportedCoin.contractAddress,supportedCoin.tokenSymbol,supportedCoin.tokenChain,
              supportedCoin.decimal,supportedCoin.tokenType,supportedCoin.tokenChainId
            ]);
        log("coin saved: $id1");
      });
    } catch (e) {
      log(e.toString());
      throw Exception("Unable save coin");
    }
  }

  Future<List<WalletModel>> getAllWallet() async {
    log("Getting all wallet");
    try {
      List<Map>? list;
      Database database = await getDatabase();
      list = await database.rawQuery('SELECT * FROM $tableWallet order by $wallet_id asc');
      log(list.toString());
      if (list.isNotEmpty) {
        return list.map((e) =>
            WalletModel(
               wallet_id: e["$wallet_id"],
              wallet_name: e["$wallet_name"],
              mnemonic: e["$mnemonic"],
              privateKey: e["$privateKey"],
                walletType: e["$walletType"]
            )).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<SupportedCoin>> getSupportedCoin(String id) async {
    log("Getting all supported coin for $wallet_id");
    try {
      List<Map>? list;
      Database database = await getDatabase();
      list = await database.rawQuery('SELECT * FROM $tableSupportedCoins where $wallet_id=? order by $asset_name',[id]);
      log(list.toString());
      if (list.isNotEmpty) {
        return list.map((e) =>
            SupportedCoin(
              id: e[id],
              wallet_id: e[wallet_id],
              asset_name: e[asset_name],
              wallet_BIP44path: e[wallet_BIP44path],
              address_index: e[address_index],
              coinImage: e[coinImage],
              coinGekoId: e[coinGekoId],
              coinType: CoinType.values.byName(e[coinType]),
              wallet_address:e[wallet_address],
              privateKey: e[privateKey],
              abi: e[abiCode],
              contractAddress: e[contractAddress],
              tokenSymbol: e[tokenSymbol],
              tokenChain: e[tokenChain],
              decimal: e[decimal],
              tokenType: e[tokenType],
                tokenChainId: e[tokenChainId]
            )).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}