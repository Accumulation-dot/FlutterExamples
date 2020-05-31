final username = "username";

final password = "password";

final inviter = 'inviter';

final page = 'page';

final size = 'size';

final status = 'status';

final number = 'number';

final price = 'price';

const method_get = "GET";

const method_post = "POST";

const method_patch = "PATCH";

const method_put = "PUT";

typedef ResponseCallback = void Function(int code, dynamic data, dynamic error);

typedef ResponseCallback2 = void Function(int code, dynamic data);

class AppConfig {
//  static const baseUrl = 'http://192.168.1.106:8000/';
  static const baseUrl = 'http://3.130.229.248:8000/';

  static const token = 'access_token';

  static const contentType_json = 'application/json';

  static final registerHtml = baseUrl + 'register.html';

  static final downloadUrl = baseUrl + 'media/app/app-release.apk';

  static AppConfig get instance => _getInstance();

  static AppConfig _instance;

  String _baseUrl;

  AppConfig._internal() {
    final isProd = bool.fromEnvironment('dart.vm.product');
    if (isProd) {
      _baseUrl = baseUrl;
    } else {
      _baseUrl = 'http://192.168.1.106:8000/';
    }
    print(_baseUrl);
  }

  static AppConfig _getInstance() {
    if (_instance == null) {
      _instance = AppConfig._internal();
    }
    return _instance;
  }
}
