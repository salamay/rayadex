// To parse this JSON data, do
//
//     final tokenData = tokenDataFromJson(jsonString);

import 'dart:convert';

TokenData tokenDataFromJson(String str) => TokenData.fromJson(json.decode(str));

String tokenDataToJson(TokenData data) => json.encode(data.toJson());

class TokenData {
  String? id;
  String? symbol;
  String? name;
  String? assetPlatformId;
  Platforms? platforms;
  DetailPlatforms? detailPlatforms;
  num? blockTimeInMinutes;
  dynamic hashingAlgorithm;
  List<String> categories;
  dynamic publicNotice;
  List<String> additionalNotices;
  Tion? localization;
  Tion? description;
  Links? links;
  Image? image;
  String? countryOrigin;
  dynamic genesisDate;
  String? contractAddress;
  dynamic sentimentVotesUpPercentage;
  dynamic sentimentVotesDownPercentage;
  num? watchlistPortfolioUsers;
  dynamic marketCapRank;
  num? coingeckoRank;
  num? coingeckoScore;
  num? developerScore;
  num? communityScore;
  num? liquidityScore;
  num? publicInterestScore;
  MarketData? marketData;
  DeveloperData? developerData;
  PublicInterestStats? publicInterestStats;
  List<dynamic> statusUpdates;
  DateTime lastUpdated;
  List<Ticker> tickers;

  TokenData({
    required this.id,
    required this.symbol,
    required this.name,
    required this.assetPlatformId,
    required this.platforms,
    required this.detailPlatforms,
    required this.blockTimeInMinutes,
    this.hashingAlgorithm,
    required this.categories,
    this.publicNotice,
    required this.additionalNotices,
    required this.localization,
    required this.description,
    required this.links,
    required this.image,
    required this.countryOrigin,
    this.genesisDate,
    required this.contractAddress,
    this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    required this.watchlistPortfolioUsers,
    this.marketCapRank,
    required this.coingeckoRank,
    required this.coingeckoScore,
    required this.developerScore,
    required this.communityScore,
    required this.liquidityScore,
    required this.publicInterestScore,
    required this.marketData,
    required this.developerData,
    required this.publicInterestStats,
    required this.statusUpdates,
    required this.lastUpdated,
    required this.tickers,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
    id: json["id"],
    symbol: json["symbol"],
    name: json["name"],
    assetPlatformId: json["asset_platform_id"],
    platforms: Platforms.fromJson(json["platforms"]),
    detailPlatforms: DetailPlatforms.fromJson(json["detail_platforms"]),
    blockTimeInMinutes: json["block_time_in_minutes"],
    hashingAlgorithm: json["hashing_algorithm"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    publicNotice: json["public_notice"],
    additionalNotices: List<String>.from(json["additional_notices"].map((x) => x)),
    localization: Tion.fromJson(json["localization"]),
    description: Tion.fromJson(json["description"]),
    links: Links.fromJson(json["links"]),
    image: Image.fromJson(json["image"]),
    countryOrigin: json["country_origin"],
    genesisDate: json["genesis_date"],
    contractAddress: json["contract_address"],
    sentimentVotesUpPercentage: json["sentiment_votes_up_percentage"],
    sentimentVotesDownPercentage: json["sentiment_votes_down_percentage"],
    watchlistPortfolioUsers: json["watchlist_portfolio_users"],
    marketCapRank: json["market_cap_rank"],
    coingeckoRank: json["coingecko_rank"],
    coingeckoScore: json["coingecko_score"]?.toDouble(),
    developerScore: json["developer_score"],
    communityScore: json["community_score"]?.toDouble(),
    liquidityScore: json["liquidity_score"],
    publicInterestScore: json["public_interest_score"],
    marketData: MarketData.fromJson(json["market_data"]),
    developerData: DeveloperData.fromJson(json["developer_data"]),
    publicInterestStats: PublicInterestStats.fromJson(json["public_interest_stats"]),
    statusUpdates: List<dynamic>.from(json["status_updates"].map((x) => x)),
    lastUpdated: DateTime.parse(json["last_updated"]),
    tickers: List<Ticker>.from(json["tickers"].map((x) => Ticker.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "asset_platform_id": assetPlatformId,
    "platforms": platforms!.toJson(),
    "detail_platforms": detailPlatforms!.toJson(),
    "block_time_in_minutes": blockTimeInMinutes,
    "hashing_algorithm": hashingAlgorithm,
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "public_notice": publicNotice,
    "additional_notices": List<dynamic>.from(additionalNotices.map((x) => x)),
    "localization": localization!.toJson(),
    "description": description!.toJson(),
    "links": links!.toJson(),
    "image": image!.toJson(),
    "country_origin": countryOrigin,
    "genesis_date": genesisDate,
    "contract_address": contractAddress,
    "sentiment_votes_up_percentage": sentimentVotesUpPercentage,
    "sentiment_votes_down_percentage": sentimentVotesDownPercentage,
    "watchlist_portfolio_users": watchlistPortfolioUsers,
    "market_cap_rank": marketCapRank,
    "coingecko_rank": coingeckoRank,
    "coingecko_score": coingeckoScore,
    "developer_score": developerScore,
    "community_score": communityScore,
    "liquidity_score": liquidityScore,
    "public_interest_score": publicInterestScore,
    "market_data": marketData!.toJson(),
    "developer_data": developerData!.toJson(),
    "public_interest_stats": publicInterestStats!.toJson(),
    "status_updates": List<dynamic>.from(statusUpdates.map((x) => x)),
    "last_updated": lastUpdated.toIso8601String(),
    "tickers": List<dynamic>.from(tickers.map((x) => x.toJson())),
  };
}

class Tion {
  String? en;
  String? de;
  String? es;
  String? fr;
  String? it;
  String? pl;
  String? ro;
  String? hu;
  String? nl;
  String? pt;
  String? sv;
  String? vi;
  String? tr;
  String? ru;
  String? ja;
  String? zh;
  String? zhTw;
  String? ko;
  String? ar;
  String? th;
  String? id;
  String? cs;
  String? da;
  String? el;
  String? hi;
  String? no;
  String? sk;
  String? uk;
  String? he;
  String? fi;
  String? bg;
  String? hr;
  String? lt;
  String? sl;

  Tion({
    required this.en,
    required this.de,
    required this.es,
    required this.fr,
    required this.it,
    required this.pl,
    required this.ro,
    required this.hu,
    required this.nl,
    required this.pt,
    required this.sv,
    required this.vi,
    required this.tr,
    required this.ru,
    required this.ja,
    required this.zh,
    required this.zhTw,
    required this.ko,
    required this.ar,
    required this.th,
    required this.id,
    required this.cs,
    required this.da,
    required this.el,
    required this.hi,
    required this.no,
    required this.sk,
    required this.uk,
    required this.he,
    required this.fi,
    required this.bg,
    required this.hr,
    required this.lt,
    required this.sl,
  });

  factory Tion.fromJson(Map<String, dynamic> json) => Tion(
    en: json["en"],
    de: json["de"],
    es: json["es"],
    fr: json["fr"],
    it: json["it"],
    pl: json["pl"],
    ro: json["ro"],
    hu: json["hu"],
    nl: json["nl"],
    pt: json["pt"],
    sv: json["sv"],
    vi: json["vi"],
    tr: json["tr"],
    ru: json["ru"],
    ja: json["ja"],
    zh: json["zh"],
    zhTw: json["zh-tw"],
    ko: json["ko"],
    ar: json["ar"],
    th: json["th"],
    id: json["id"],
    cs: json["cs"],
    da: json["da"],
    el: json["el"],
    hi: json["hi"],
    no: json["no"],
    sk: json["sk"],
    uk: json["uk"],
    he: json["he"],
    fi: json["fi"],
    bg: json["bg"],
    hr: json["hr"],
    lt: json["lt"],
    sl: json["sl"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "de": de,
    "es": es,
    "fr": fr,
    "it": it,
    "pl": pl,
    "ro": ro,
    "hu": hu,
    "nl": nl,
    "pt": pt,
    "sv": sv,
    "vi": vi,
    "tr": tr,
    "ru": ru,
    "ja": ja,
    "zh": zh,
    "zh-tw": zhTw,
    "ko": ko,
    "ar": ar,
    "th": th,
    "id": id,
    "cs": cs,
    "da": da,
    "el": el,
    "hi": hi,
    "no": no,
    "sk": sk,
    "uk": uk,
    "he": he,
    "fi": fi,
    "bg": bg,
    "hr": hr,
    "lt": lt,
    "sl": sl,
  };
}

class DetailPlatforms {
  BinanceSmartChain binanceSmartChain;

  DetailPlatforms({
    required this.binanceSmartChain,
  });

  factory DetailPlatforms.fromJson(Map<String, dynamic> json) => DetailPlatforms(
    binanceSmartChain: BinanceSmartChain.fromJson(json["binance-smart-chain"]),
  );

  Map<String, dynamic> toJson() => {
    "binance-smart-chain": binanceSmartChain.toJson(),
  };
}

class BinanceSmartChain {
  int? decimalPlace;
  String? contractAddress;

  BinanceSmartChain({
    required this.decimalPlace,
    required this.contractAddress,
  });

  factory BinanceSmartChain.fromJson(Map<String, dynamic> json) => BinanceSmartChain(
    decimalPlace: json["decimal_place"],
    contractAddress: json["contract_address"],
  );

  Map<String, dynamic> toJson() => {
    "decimal_place": decimalPlace,
    "contract_address": contractAddress,
  };
}

class DeveloperData {
  int? forks;
  int? stars;
  int? subscribers;
  int? totalIssues;
  int? closedIssues;
  int? pullRequestsMerged;
  int? pullRequestContributors;
  CodeAdditionsDeletions4Weeks codeAdditionsDeletions4Weeks;
  int? commitCount4Weeks;
  List<dynamic> last4WeeksCommitActivitySeries;

  DeveloperData({
    required this.forks,
    required this.stars,
    required this.subscribers,
    required this.totalIssues,
    required this.closedIssues,
    required this.pullRequestsMerged,
    required this.pullRequestContributors,
    required this.codeAdditionsDeletions4Weeks,
    required this.commitCount4Weeks,
    required this.last4WeeksCommitActivitySeries,
  });

  factory DeveloperData.fromJson(Map<String, dynamic> json) => DeveloperData(
    forks: json["forks"],
    stars: json["stars"],
    subscribers: json["subscribers"],
    totalIssues: json["total_issues"],
    closedIssues: json["closed_issues"],
    pullRequestsMerged: json["pull_requests_merged"],
    pullRequestContributors: json["pull_request_contributors"],
    codeAdditionsDeletions4Weeks: CodeAdditionsDeletions4Weeks.fromJson(json["code_additions_deletions_4_weeks"]),
    commitCount4Weeks: json["commit_count_4_weeks"],
    last4WeeksCommitActivitySeries: List<dynamic>.from(json["last_4_weeks_commit_activity_series"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "forks": forks,
    "stars": stars,
    "subscribers": subscribers,
    "total_issues": totalIssues,
    "closed_issues": closedIssues,
    "pull_requests_merged": pullRequestsMerged,
    "pull_request_contributors": pullRequestContributors,
    "code_additions_deletions_4_weeks": codeAdditionsDeletions4Weeks.toJson(),
    "commit_count_4_weeks": commitCount4Weeks,
    "last_4_weeks_commit_activity_series": List<dynamic>.from(last4WeeksCommitActivitySeries.map((x) => x)),
  };
}

class CodeAdditionsDeletions4Weeks {
  dynamic additions;
  dynamic deletions;

  CodeAdditionsDeletions4Weeks({
    this.additions,
    this.deletions,
  });

  factory CodeAdditionsDeletions4Weeks.fromJson(Map<String, dynamic> json) => CodeAdditionsDeletions4Weeks(
    additions: json["additions"],
    deletions: json["deletions"],
  );

  Map<String, dynamic> toJson() => {
    "additions": additions,
    "deletions": deletions,
  };
}

class Image {
  String? thumb;
  String? small;
  String? large;

  Image({
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    thumb: json["thumb"],
    small: json["small"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "thumb": thumb,
    "small": small,
    "large": large,
  };
}

class Links {
  List<String> homepage;
  List<String> blockchainSite;
  List<String> officialForumUrl;
  List<String> chatUrl;
  List<String> announcementUrl;
  String twitterScreenName;
  String facebookUsername;
  dynamic bitcointalkThreadIdentifier;
  String telegramChannelIdentifier;
  dynamic subredditUrl;
  ReposUrl reposUrl;

  Links({
    required this.homepage,
    required this.blockchainSite,
    required this.officialForumUrl,
    required this.chatUrl,
    required this.announcementUrl,
    required this.twitterScreenName,
    required this.facebookUsername,
    this.bitcointalkThreadIdentifier,
    required this.telegramChannelIdentifier,
    this.subredditUrl,
    required this.reposUrl,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    homepage: List<String>.from(json["homepage"].map((x) => x)),
    blockchainSite: List<String>.from(json["blockchain_site"].map((x) => x)),
    officialForumUrl: List<String>.from(json["official_forum_url"].map((x) => x)),
    chatUrl: List<String>.from(json["chat_url"].map((x) => x)),
    announcementUrl: List<String>.from(json["announcement_url"].map((x) => x)),
    twitterScreenName: json["twitter_screen_name"],
    facebookUsername: json["facebook_username"],
    bitcointalkThreadIdentifier: json["bitcointalk_thread_identifier"],
    telegramChannelIdentifier: json["telegram_channel_identifier"],
    subredditUrl: json["subreddit_url"],
    reposUrl: ReposUrl.fromJson(json["repos_url"]),
  );

  Map<String, dynamic> toJson() => {
    "homepage": List<dynamic>.from(homepage.map((x) => x)),
    "blockchain_site": List<dynamic>.from(blockchainSite.map((x) => x)),
    "official_forum_url": List<dynamic>.from(officialForumUrl.map((x) => x)),
    "chat_url": List<dynamic>.from(chatUrl.map((x) => x)),
    "announcement_url": List<dynamic>.from(announcementUrl.map((x) => x)),
    "twitter_screen_name": twitterScreenName,
    "facebook_username": facebookUsername,
    "bitcointalk_thread_identifier": bitcointalkThreadIdentifier,
    "telegram_channel_identifier": telegramChannelIdentifier,
    "subreddit_url": subredditUrl,
    "repos_url": reposUrl.toJson(),
  };
}

class ReposUrl {
  List<String> github;
  List<dynamic> bitbucket;

  ReposUrl({
    required this.github,
    required this.bitbucket,
  });

  factory ReposUrl.fromJson(Map<String, dynamic> json) => ReposUrl(
    github: List<String>.from(json["github"].map((x) => x)),
    bitbucket: List<dynamic>.from(json["bitbucket"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "github": List<dynamic>.from(github.map((x) => x)),
    "bitbucket": List<dynamic>.from(bitbucket.map((x) => x)),
  };
}

class MarketData {
  Map<String, double> currentPrice;
  dynamic totalValueLocked;
  dynamic mcapToTvlRatio;
  dynamic fdvToTvlRatio;
  dynamic roi;
  Map<String, double> ath;
  Map<String, double> athChangePercentage;
  Map<String, DateTime> athDate;
  Map<String, double> atl;
  Map<String, double> atlChangePercentage;
  Map<String, DateTime> atlDate;
  Map<String, double> marketCap;
  dynamic marketCapRank;
  Map<String, double> fullyDilutedValuation;
  Map<String, double> totalVolume;
  Map<String, double> high24H;
  Map<String, double> low24H;
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? priceChangePercentage7D;
  double? priceChangePercentage14D;
  double? priceChangePercentage30D;
  double? priceChangePercentage60D;
  double? priceChangePercentage200D;
  double? priceChangePercentage1Y;
  double? marketCapChange24H;
  double? marketCapChangePercentage24H;
  Map<String, double> priceChange24HInCurrency;
  Map<String, double> priceChangePercentage1HInCurrency;
  Map<String, double> priceChangePercentage24HInCurrency;
  Map<String, double> priceChangePercentage7DInCurrency;
  Map<String, double> priceChangePercentage14DInCurrency;
  Map<String, double> priceChangePercentage30DInCurrency;
  Map<String, double> priceChangePercentage60DInCurrency;
  Map<String, double> priceChangePercentage200DInCurrency;
  Map<String, double> priceChangePercentage1YInCurrency;
  Map<String, double> marketCapChange24HInCurrency;
  Map<String, double> marketCapChangePercentage24HInCurrency;
  double? totalSupply;
  double? maxSupply;
  double? circulatingSupply;
  DateTime lastUpdated;

  MarketData({
    required this.currentPrice,
    this.totalValueLocked,
    this.mcapToTvlRatio,
    this.fdvToTvlRatio,
    this.roi,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.marketCap,
    this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.priceChangePercentage7D,
    required this.priceChangePercentage14D,
    required this.priceChangePercentage30D,
    required this.priceChangePercentage60D,
    required this.priceChangePercentage200D,
    required this.priceChangePercentage1Y,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.priceChange24HInCurrency,
    required this.priceChangePercentage1HInCurrency,
    required this.priceChangePercentage24HInCurrency,
    required this.priceChangePercentage7DInCurrency,
    required this.priceChangePercentage14DInCurrency,
    required this.priceChangePercentage30DInCurrency,
    required this.priceChangePercentage60DInCurrency,
    required this.priceChangePercentage200DInCurrency,
    required this.priceChangePercentage1YInCurrency,
    required this.marketCapChange24HInCurrency,
    required this.marketCapChangePercentage24HInCurrency,
    required this.totalSupply,
    required this.maxSupply,
    required this.circulatingSupply,
    required this.lastUpdated,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) => MarketData(
    currentPrice: Map.from(json["current_price"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    totalValueLocked: json["total_value_locked"],
    mcapToTvlRatio: json["mcap_to_tvl_ratio"],
    fdvToTvlRatio: json["fdv_to_tvl_ratio"],
    roi: json["roi"],
    ath: Map.from(json["ath"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    athChangePercentage: Map.from(json["ath_change_percentage"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    athDate: Map.from(json["ath_date"]).map((k, v) => MapEntry<String, DateTime>(k, DateTime.parse(v))),
    atl: Map.from(json["atl"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    atlChangePercentage: Map.from(json["atl_change_percentage"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    atlDate: Map.from(json["atl_date"]).map((k, v) => MapEntry<String, DateTime>(k, DateTime.parse(v))),
    marketCap: Map.from(json["market_cap"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    marketCapRank: json["market_cap_rank"],
    fullyDilutedValuation: Map.from(json["fully_diluted_valuation"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    totalVolume: Map.from(json["total_volume"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    high24H: Map.from(json["high_24h"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    low24H: Map.from(json["low_24h"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChange24H: json["price_change_24h"]?.toDouble(),
    priceChangePercentage24H: json["price_change_percentage_24h"]?.toDouble(),
    priceChangePercentage7D: json["price_change_percentage_7d"]?.toDouble(),
    priceChangePercentage14D: json["price_change_percentage_14d"]?.toDouble(),
    priceChangePercentage30D: json["price_change_percentage_30d"]?.toDouble(),
    priceChangePercentage60D: json["price_change_percentage_60d"]?.toDouble(),
    priceChangePercentage200D: json["price_change_percentage_200d"]?.toDouble(),
    priceChangePercentage1Y: json["price_change_percentage_1y"]?.toDouble(),
    marketCapChange24H: json["market_cap_change_24h"],
    marketCapChangePercentage24H: json["market_cap_change_percentage_24h"],
    priceChange24HInCurrency: Map.from(json["price_change_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage1HInCurrency: Map.from(json["price_change_percentage_1h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage24HInCurrency: Map.from(json["price_change_percentage_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage7DInCurrency: Map.from(json["price_change_percentage_7d_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage14DInCurrency: Map.from(json["price_change_percentage_14d_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage30DInCurrency: Map.from(json["price_change_percentage_30d_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage60DInCurrency: Map.from(json["price_change_percentage_60d_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage200DInCurrency: Map.from(json["price_change_percentage_200d_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    priceChangePercentage1YInCurrency: Map.from(json["price_change_percentage_1y_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    marketCapChange24HInCurrency: Map.from(json["market_cap_change_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    marketCapChangePercentage24HInCurrency: Map.from(json["market_cap_change_percentage_24h_in_currency"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    totalSupply: json["total_supply"],
    maxSupply: json["max_supply"],
    circulatingSupply: json["circulating_supply"],
    lastUpdated: DateTime.parse(json["last_updated"]),
  );

  Map<String, dynamic> toJson() => {
    "current_price": Map.from(currentPrice).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "total_value_locked": totalValueLocked,
    "mcap_to_tvl_ratio": mcapToTvlRatio,
    "fdv_to_tvl_ratio": fdvToTvlRatio,
    "roi": roi,
    "ath": Map.from(ath).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "ath_change_percentage": Map.from(athChangePercentage).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "ath_date": Map.from(athDate).map((k, v) => MapEntry<String, dynamic>(k, v.toIso8601String())),
    "atl": Map.from(atl).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "atl_change_percentage": Map.from(atlChangePercentage).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "atl_date": Map.from(atlDate).map((k, v) => MapEntry<String, dynamic>(k, v.toIso8601String())),
    "market_cap": Map.from(marketCap).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "market_cap_rank": marketCapRank,
    "fully_diluted_valuation": Map.from(fullyDilutedValuation).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "total_volume": Map.from(totalVolume).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "high_24h": Map.from(high24H).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "low_24h": Map.from(low24H).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_24h": priceChange24H,
    "price_change_percentage_24h": priceChangePercentage24H,
    "price_change_percentage_7d": priceChangePercentage7D,
    "price_change_percentage_14d": priceChangePercentage14D,
    "price_change_percentage_30d": priceChangePercentage30D,
    "price_change_percentage_60d": priceChangePercentage60D,
    "price_change_percentage_200d": priceChangePercentage200D,
    "price_change_percentage_1y": priceChangePercentage1Y,
    "market_cap_change_24h": marketCapChange24H,
    "market_cap_change_percentage_24h": marketCapChangePercentage24H,
    "price_change_24h_in_currency": Map.from(priceChange24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_1h_in_currency": Map.from(priceChangePercentage1HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_24h_in_currency": Map.from(priceChangePercentage24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_7d_in_currency": Map.from(priceChangePercentage7DInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_14d_in_currency": Map.from(priceChangePercentage14DInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_30d_in_currency": Map.from(priceChangePercentage30DInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_60d_in_currency": Map.from(priceChangePercentage60DInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_200d_in_currency": Map.from(priceChangePercentage200DInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "price_change_percentage_1y_in_currency": Map.from(priceChangePercentage1YInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "market_cap_change_24h_in_currency": Map.from(marketCapChange24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "market_cap_change_percentage_24h_in_currency": Map.from(marketCapChangePercentage24HInCurrency).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "total_supply": totalSupply,
    "max_supply": maxSupply,
    "circulating_supply": circulatingSupply,
    "last_updated": lastUpdated.toIso8601String(),
  };
}

class Platforms {
  String binanceSmartChain;

  Platforms({
    required this.binanceSmartChain,
  });

  factory Platforms.fromJson(Map<String, dynamic> json) => Platforms(
    binanceSmartChain: json["binance-smart-chain"],
  );

  Map<String, dynamic> toJson() => {
    "binance-smart-chain": binanceSmartChain,
  };
}

class PublicInterestStats {
  dynamic alexaRank;
  dynamic bingMatches;

  PublicInterestStats({
    this.alexaRank,
    this.bingMatches,
  });

  factory PublicInterestStats.fromJson(Map<String, dynamic> json) => PublicInterestStats(
    alexaRank: json["alexa_rank"],
    bingMatches: json["bing_matches"],
  );

  Map<String, dynamic> toJson() => {
    "alexa_rank": alexaRank,
    "bing_matches": bingMatches,
  };
}

class Ticker {
  String? base;
  String? target;
  Market market;
  double? last;
  double? volume;
  Map<String, double> convertedLast;
  Map<String, double> convertedVolume;
  dynamic trustScore;
  double? bidAskSpreadPercentage;
  DateTime timestamp;
  DateTime lastTradedAt;
  DateTime lastFetchAt;
  bool isAnomaly;
  bool isStale;
  String? tradeUrl;
  dynamic tokenInfoUrl;
  String? coinId;
  String? targetCoinId;

  Ticker({
    required this.base,
    required this.target,
    required this.market,
    required this.last,
    required this.volume,
    required this.convertedLast,
    required this.convertedVolume,
    this.trustScore,
    required this.bidAskSpreadPercentage,
    required this.timestamp,
    required this.lastTradedAt,
    required this.lastFetchAt,
    required this.isAnomaly,
    required this.isStale,
    required this.tradeUrl,
    this.tokenInfoUrl,
    required this.coinId,
    required this.targetCoinId,
  });

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
    base: json["base"],
    target: json["target"],
    market: Market.fromJson(json["market"]),
    last: json["last"]?.toDouble(),
    volume: json["volume"]?.toDouble(),
    convertedLast: Map.from(json["converted_last"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    convertedVolume: Map.from(json["converted_volume"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    trustScore: json["trust_score"],
    bidAskSpreadPercentage: json["bid_ask_spread_percentage"]?.toDouble(),
    timestamp: DateTime.parse(json["timestamp"]),
    lastTradedAt: DateTime.parse(json["last_traded_at"]),
    lastFetchAt: DateTime.parse(json["last_fetch_at"]),
    isAnomaly: json["is_anomaly"],
    isStale: json["is_stale"],
    tradeUrl: json["trade_url"],
    tokenInfoUrl: json["token_info_url"],
    coinId: json["coin_id"],
    targetCoinId: json["target_coin_id"],
  );

  Map<String, dynamic> toJson() => {
    "base": base,
    "target": target,
    "market": market.toJson(),
    "last": last,
    "volume": volume,
    "converted_last": Map.from(convertedLast).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "converted_volume": Map.from(convertedVolume).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "trust_score": trustScore,
    "bid_ask_spread_percentage": bidAskSpreadPercentage,
    "timestamp": timestamp.toIso8601String(),
    "last_traded_at": lastTradedAt.toIso8601String(),
    "last_fetch_at": lastFetchAt.toIso8601String(),
    "is_anomaly": isAnomaly,
    "is_stale": isStale,
    "trade_url": tradeUrl,
    "token_info_url": tokenInfoUrl,
    "coin_id": coinId,
    "target_coin_id": targetCoinId,
  };
}

class Market {
  String? name;
  String? identifier;
  bool? hasTradingIncentive;

  Market({
    required this.name,
    required this.identifier,
    required this.hasTradingIncentive,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
    name: json["name"],
    identifier: json["identifier"],
    hasTradingIncentive: json["has_trading_incentive"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "identifier": identifier,
    "has_trading_incentive": hasTradingIncentive,
  };
}
