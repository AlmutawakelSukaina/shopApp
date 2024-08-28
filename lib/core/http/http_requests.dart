



import 'package:http/http.dart';

import '../../libs.dart';

mixin class BasedHttpRequests  {

  Future<NetworkServiceResponse> getData<T>(String url,
      {dynamic parameter}) async {


    globalPrint("url inside $url");
      final request = Request('GET', Uri.parse(url)) ;

      if(parameter!=null) {
        request.body = json.encode(parameter);
      }
      final response = await request.send().timeout(const Duration(seconds: 40),
          onTimeout: () {
            throw TimeOutException(kTimeOutException);
          });
      final res = await Response.fromStream(response);

      return res.processResponse();
    }

  Future<NetworkServiceResponse> postData
      ({required String url, required dynamic parameter,String ?method,}) async {




    final response = await post(
    Uri.parse(url),
      headers: getHeader() ,

      body:parameter!=null? utf8.encode(json.encode(parameter)):null,
    ).timeout(const Duration(seconds: 40),
        onTimeout: () {
          throw TimeOutException(kTimeOutException);
        });
    globalPrint('post parameter $parameter');
    globalPrint('post url $url');

    globalPrint('post response ${response.body}');
    globalPrint('post statusCode ${response.statusCode}');

    return response.processResponse();
  }

  Map<String, String>   getHeader()   {
    Map<String, String> header = {};

    header['content-type'] = 'application/json';


    return header;
  }
  }




