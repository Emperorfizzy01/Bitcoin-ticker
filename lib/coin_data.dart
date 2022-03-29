import 'package:http/http.dart' as http;
import 'dart:convert';

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

var url = 'https://rest.coinapi.io/v1/exchangerate';
var apiKey = '2E32F52F-4253-4057-A7DC-5A7CBE991F98';

class CoinData {
  Future getCryptoPrice(String selectedCurrency) async {
    http.Response response = await http.get(
      Uri.parse('$url/BTC/$selectedCurrency?apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      String body = response.body;
      var decodeData = jsonDecode(body);
      double lastPrice = decodeData['rate'];
      return lastPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
    }
  }
}
