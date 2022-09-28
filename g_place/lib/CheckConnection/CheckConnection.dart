import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/load.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      hideLoadingDialog();
    } else if (result == ConnectivityResult.none) {
      showCustomLoadingWidget(
          Center(
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 142, 137, 137),
                      borderRadius: BorderRadius.circular(10)),
                  height: 70,
                  width: 70,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 42, 41, 41),
                  )),
                )),
          ),
          tapDismiss: false);
    }
  }

  Future<void> listenersForConnection() async {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}
