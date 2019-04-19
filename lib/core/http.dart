import 'dart:convert';
import 'dart:io';

class HTTPResult {
  String body;
  int status = HttpStatus.notFound;
}

class HTTP {
  static String HttpExpception = "HTTP_ERROR_WITH_EXCEPTION";
  static String HttpERRORCode = "HTTP_ERROR_WITH_NO200";

  static Future<HTTPResult> Get(HttpClient httpClient, String url,
      {String useragent, String referer, String cookies}) async {
    HTTPResult result;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      result.status = response.statusCode;
      if (response.statusCode == HttpStatus.ok) {
        result.body = await response.transform(utf8.decoder).join();
      } else {
        result.body = HttpERRORCode;
      }
    } catch (exception) {
      result.body = HttpExpception;
    }

    return result;
  }
}
