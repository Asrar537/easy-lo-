import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpServices {
  static Future<dynamic> getDetail(String userUrl) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$userUrl&format=json";
    var res = await http.get(embedUrl);
    print("get youtube detail status code: " + res.statusCode.toString());

    try {
      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return null;
      }
    } on FormatException catch (e) {
      print('invalid JSON from file HttpServices' + e.toString());
      return null;
    }
  }
}
