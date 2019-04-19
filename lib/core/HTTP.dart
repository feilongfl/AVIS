import 'dart:convert';
import 'dart:io';

import '../common/AppEnums.dart';

class HTTPResult {
  String body;
  int status = HttpStatus.notFound;
}

class HTTP {
  static String HttpExpception = "HTTP_ERROR_WITH_EXCEPTION";
  static String HttpERRORCode = "HTTP_ERROR_WITH_NO200";

  static Future<HTTPResult> Get(HttpClient httpClient, String url,
      {String useragent, String referer, String cookies, String data}) async {
    HTTPResult result = new HTTPResult();

    try {
      var request = await httpClient
          .getUrl(Uri.parse(data == null ? "$url" : "$url?$data"));
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

  static Future<HTTPResult> work(HttpClient httpClient, String url,
      {String useragent,
      String referer,
      String cookies,
      HttpMethod method,
      String data}) async {
    switch (method ?? HttpMethod.Get) {
      case HttpMethod.Get:
        {
          return Get(httpClient, url,
              useragent: useragent,
              referer: referer,
              cookies: cookies,
              data: data);
        }
        break;
      case HttpMethod.Post:
        {
          return HTTPResult(); //todo complete here
        }
        break;

      default:
        return HTTPResult(); //todo complete here
        break;
    }
  }
}
