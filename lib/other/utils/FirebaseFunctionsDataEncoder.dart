import 'dart:convert';

class FirebaseFunctionsDataEncoder {
  static Map<String, dynamic> extractData(Map<dynamic, dynamic> data) {
    Map<String, dynamic> encodedData = new Map();
    data.forEach((key, value) {
      encodedData[key.toString()] = value;
    });
    return jsonDecode(jsonEncode(encodedData));
  }
}
