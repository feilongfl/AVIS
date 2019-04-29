import 'dart:convert';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../common/AppEnums.dart';

class HTTPResult {
  String body;
  int status = HttpStatus.notFound;
}

class _HttpCacheManager extends BaseCacheManager {
  static const key = "httpcache";

  static _HttpCacheManager _instance;

  /// The DefaultCacheManager that can be easily used directly. The code of
  /// this implementation can be used as inspiration for more complex cache
  /// managers.
  factory _HttpCacheManager() {
    if (_instance == null) {
      _instance = new _HttpCacheManager._();
    }
    return _instance;
  }

  _HttpCacheManager._()
      : super(
          key,
          maxAgeCacheObject: Duration(minutes: 60),
          maxNrOfCacheObjects: 200,
        );

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }
}

class HTTP {
  static String HttpExpception = "HTTP_ERROR_WITH_EXCEPTION";
  static String HttpERRORCode = "HTTP_ERROR_WITH_NO200";

  static Future<HTTPResult> get(HttpClient httpClient, String url,
      {String useragent, String referer, String cookies, String data}) async {
    HTTPResult result = new HTTPResult();

    var file = await _HttpCacheManager().getFileFromCache(url);
    if (file != null) {
      HTTPResult hr = HTTPResult();
      hr.body = utf8.decode(file.file.readAsBytesSync());
      hr.status = HttpStatus.ok;
      return hr;
    }

    try {
      var request = await httpClient
          .getUrl(Uri.parse(data == null ? "$url" : "$url?$data"));
      var response = await request.close();

      result.status = response.statusCode;
      if (response.statusCode == HttpStatus.ok) {
        result.body = await response.transform(utf8.decoder).join();
        await _HttpCacheManager().putFile(url, utf8.encode(result.body));
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
          return get(httpClient, url,
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
