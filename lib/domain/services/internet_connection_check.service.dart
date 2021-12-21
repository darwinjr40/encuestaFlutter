import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionStatusModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectionSubscription;
  static bool _isOnline = false;

  ConnectionStatusModel() {
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((_) => checkInternetConnection());
    checkInternetConnection();
  }

  static bool get isOnline => _isOnline;

  Future<bool> checkInternetConnection() async {
    try {
      // Sometimes the callback is called when we reconnect to wifi, but the internet is not really functional
      // This delay try to wait until we are really connected to internet
      await Future.delayed(const Duration(seconds: 0));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    //print('se ejecutó el check');
    //print(this._isOnline);

    notifyListeners();
    return _isOnline;
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
