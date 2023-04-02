

import 'package:pocket_pay_app/api/api_utils/network_exception.dart';

import '../models/customer/errorModel.dart';

dynamic responseHandler(response, {bool hideLog = false}) async {
  //Attempt to derive error message
  String? exceptionMsg;
  String exceptionCode;
  ErrorModel? responseBody;
  try {
    responseBody = errorModelFromJson(response.body);
    exceptionMsg = responseBody.message;
  } catch (e) {
    print("Error deriving error message: $e");
    exceptionMsg = response.body;
    // exceptionCode = response.statusCode.toString();
  }

  if (!hideLog) {
    print(response.body);
    print("status code: ${response.statusCode}");
  }

  switch (response.statusCode) {
    case 201:
      return response.body;
      break;
    case 200:
      return response.body;
      break;
    case 400:
      throw BadRequestException(exceptionMsg);
    case 401:
    case 403:
      throw UnauthorisedException(exceptionMsg);
    case 404:
      throw FileNotFoundException(exceptionMsg);
    case 422:
    case 500:
      //extract errors
      try {
        if (responseBody?.message != null) {
          exceptionMsg = responseBody?.message;
        }
      } catch (e) {
        print("could not extract errors");
      }

      throw AlreadyRegisteredException(exceptionMsg);

    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
