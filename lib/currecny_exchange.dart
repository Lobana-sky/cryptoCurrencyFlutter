import 'package:bitcoin_ticker/network.dart';
import 'network.dart';

const apiKey = 'D9829E4B-046D-4674-9D4F-CB0BDD9003C6';
const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CurrencyExchange {
  Future<dynamic> getExchangeData(String cryptoCurrency, String currency) async {
    String url = '$baseUrl/$cryptoCurrency/$currency?apikey=$apiKey';
    NetworkService network = NetworkService(url);
    return await network.getData();
  }
}
