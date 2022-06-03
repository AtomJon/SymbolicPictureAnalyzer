import 'package:http/http.dart' as http;

bool _checkIfImage(String param) {
  if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
    return true;
  }
  return false;
}

Future<bool> validateImage(String imageUrl) async {
  http.Response res;
  try {
    res = await http.get(Uri.parse(imageUrl));
  } catch (e) {
    return false;
  }

  if (res.statusCode != 200) return false;

  final Map<String, String> data = res.headers;

  final String? contentType = data['content-type'];

  if (contentType == null) return false;

  return _checkIfImage(contentType);
}
