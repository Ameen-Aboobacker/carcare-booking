import 'dart:convert';

import 'package:http/http.dart' as http;

class RazorpayId {
  String keyId;
  String keySecret;

  RazorpayId(this.keyId, this.keySecret);

  Future<http.Response> createOrder(Map<String, dynamic> orderData) async {
    var url = Uri.parse('https://api.razorpay.com/v1/orders');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${base64Encode(utf8.encode("$keyId:$keySecret"))}',
    };

    var body = json.encode(orderData);

    var response = await http.post(url, headers: headers, body: body);
    return response;
  }
}