import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  var data;
  var price;

  NetworkHelper();

  Future<dynamic> getData(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      price = data['last'];
      return price;
    } else {
      print(response.statusCode);
      throw "issue getting the data in network helper";
    }

//    print(data);
  }
}
