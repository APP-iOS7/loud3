import 'package:http/http.dart' as http;

class ApiTest {
  //https://jsonplaceholder.typicode.com/posts

  static Future<String?> fetchData() async {
    Uri url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
    try {
      var fetch = await http.get(
        url,
        headers: {'Content-type': 'application/json'},
      );
      return fetch.body;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
