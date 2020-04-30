import 'package:http/http.dart' as http;

class SinixClient {
  var _client = http.Client();
  String _url;

  Future<void> get(){
    _client.get()
  }

  bool handshake(String ipAddr){
    String url = "http://$ipAddr:4143/graphql";

    _client.post(url, body: {
      
    });
    return false;
  }
}


var sinixClient = SinixClient();