import 'package:dio/dio.dart';

class DEInfo {
  final int code;
  final String message;

  DEInfo(this.code, this.message);

  static DEInfo info(DioError error) {
    print('error.response.data is ${error.response.data}');
    String message = '';
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        message = '连接超时';
        break;

      case DioErrorType.SEND_TIMEOUT:
        message = '发送超时，请检查网络';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = '接受超时，请检查网络';
        break;
      case DioErrorType.CANCEL:
        message = '用户取消';
        break;
      case DioErrorType.RESPONSE:
        message = error.response.data.toString() ?? '系统异常';
        break;
      default:
        message = '系统错误';
        break;
    }
    return DEInfo(error.response.statusCode, message);
  }
}
