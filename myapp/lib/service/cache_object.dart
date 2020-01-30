import 'package:dio/dio.dart';

class CacheObject {
  /// property
  Response response;
  
  int timeStamp;
  
  /// constructor 
  CacheObject(this.response): timeStamp = DateTime.now().millisecondsSinceEpoch;

  /// override
  /// 
  @override
  bool operator ==(other) {
    return this.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}