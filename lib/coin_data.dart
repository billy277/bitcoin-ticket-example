import 'network_helper.dart';

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XRP',
  'BCH',
];

class CoinData {
  NetworkHelper networkHelper = NetworkHelper();
  CoinData();

  Future<Map<String, String>> getCoinData(String curr) async {
    //use currency to get the price data
    Map<String, String> cryptoPrices = {};
    for (String coin in cryptoList) {
      String urlUpdated = '$url$coin$curr';
      print('updated url is:  $urlUpdated');
      try {
        double price = await networkHelper.getData(urlUpdated);
        cryptoPrices[coin] = price.toStringAsFixed(2);
      } catch (e) {
        print(e);
        throw 'error with getCoin Data';
      }
    }
    return cryptoPrices;
  }
}
