import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends InterceptorContract {

  final Logger logger = Logger();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {

    logger.i(
      "REQUEST\n"
      "URL: ${request.url}\n"
      "HEADERS: ${request.headers}\n"
    );

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {

    logger.i(
      "RESPONSE\n"
      "STATUS: ${response.statusCode}"
    );

    if (response is Response) {
      logger.d("BODY: ${response.body}");
    }

    return response;
  }
}