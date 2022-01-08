import 'package:connectivity/connectivity.dart';

class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<bool> checks() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      }
      return false;
    } catch (Exception) {
      return false;
    }
  }

  dynamic checkInternet(Function func) {
    checks().then((intenet) {
      if (intenet != null && intenet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
