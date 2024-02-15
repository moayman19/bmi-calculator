import 'dart:convert';

import 'package:http/http.dart' as http;

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
];

class CoinData {
  Future<List> getCoinData() async {
    List<dynamic> rateList = [];

    for (String currency in currenciesList) {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apiKey=C89E43CE-8163-4A28-AB7A-F23712BE77BF';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var btcRate = decodedData['rate'];
        var finalBtcRate = btcRate.toStringAsFixed(0);

        rateList.add(finalBtcRate);
      } else
        (e) {
          print("eror in api ${response.statusCode}");
        };
    }

    return rateList;
  }
}
