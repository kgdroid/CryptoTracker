import 'dart:async';
import 'dart:convert';

import 'package:crypto_tracker/widgets/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/coin_card.dart';
import '../models/coin.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  final items = <Widget>[
    const Icon(Icons.favorite),
    const Icon(Icons.home),
    const Icon(Icons.settings),
  ];

  final textItems = ["Bookmark", "Cryptotracker", "Profile"];

  bool light = true;
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor:
              light == true ? Colors.grey[300]! : Colors.grey[900]!,
          animationDuration: const Duration(milliseconds: 300),
          color: light == true ? Colors.grey[200]! : Colors.grey[800]!,
          onTap: (index) => setState((() => this.index = index)),
          items: items,
          index: index,
        ),
        backgroundColor: light == true ? Colors.grey[300] : Colors.grey[900],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: light == true ? Colors.grey[300] : Colors.grey[900],
          title: GestureDetector(
            onTap: () {
              //Theme Change
              setState(() {
                if (light) {
                  light = false;
                } else {
                  light = true;
                }
              });
            },
            child: Text(textItems[index],
                style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: light == true ? Colors.grey[900] : Colors.white)),
          ),
        ),
        body: page(index, light));
  }
}

Widget page(int index, bool light) {
  switch (index) {
    case 0:
      return fav(light);
      break;
    case 1:
      return homeItems(light);
      break;
    case 2:
      return profile(light);
      break;
  }
  return HomePage();
}

Widget homeItems(bool light) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: coinList.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  padding: EdgeInsets.zero,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  backgroundColor: Colors.redAccent,
                  icon: Icons.favorite,
                  label: 'love',
                  onPressed: (BuildContext context) {},
                )
              ],
            ),
            child: CoinCard(
              light: light,
              name: coinList[index].name,
              symbol: coinList[index].symbol,
              imageUrl: coinList[index].imageUrl,
              price: coinList[index].price.toDouble(),
              change: coinList[index].change.toDouble(),
              rank: coinList[index].rank.toDouble(),
            ),
          ),
        ],
      );
    },
  );
}

Widget fav(bool light) {
  return Text("Fav");
}

Widget profile(bool light) {
  return ProfilePage();
}
