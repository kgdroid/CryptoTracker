
class Coin {
  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.rank,
  });

  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num rank;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      rank: json['market_cap_rank'],
    );
  }
}

List<Coin> coinList = [];
