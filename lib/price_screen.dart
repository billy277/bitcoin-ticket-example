import 'package:bitcoin_ticker/cryptoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'cryptoCard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';
//  List<double> currPrice = List<double>(cryptoList.length);
//  List<String> priceAsString = List<String>(cryptoList.length);

  void initState() {
    getPrice();
    super.initState();
  }

  Map<String, String> cryptoPrices = {};
  bool isWaiting = false;

  void getPrice() async {
    isWaiting = true;
    try {
      var tmp = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoPrices = tmp;
      });
    } catch (e) {
      print(e);
    }
    print(cryptoPrices);
  }

  List<Widget> makeListOfPrices() {
    List<Widget> list = [];
    for (int i = 0; i < cryptoList.length; i++) {
      CryptoCard tmp = CryptoCard(
        value: isWaiting ? '?' : cryptoPrices[cryptoList[i]],
        selectedCurrency: selectedCurrency,
        coin: cryptoList[i],
      );
      list.add(tmp);
    }
    return list;
  }

  DropdownButton<String> getAndroidWidget() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> listEntry = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(listEntry);
    }
    return DropdownButton<String>(
      value: selectedCurrency, // this is the value that it shows
      items: list,
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
          getPrice();
        });
      }, // list of items to be shown in the dropdown
    );
  }

  CupertinoPicker getIOSWidget() {
    List<Widget> list = [];

    for (String currency in currenciesList) {
      list.add(Text(currency, style: TextStyle(color: Colors.white)));
    }
    return CupertinoPicker(
      children: list, // list to be implemented
      onSelectedItemChanged: (int value) {
        setState(() {
//          clearData();
          selectedCurrency = currenciesList[value];

          getPrice();
        });
      }, //call back after selecting an item
      itemExtent: 28, //size of the picker
      backgroundColor: Colors.lightBlue,
      useMagnifier: true,
      magnification: 1.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: makeListOfPrices(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getIOSWidget() : getAndroidWidget(),
          ),
        ],
      ),
    );
  }
}
