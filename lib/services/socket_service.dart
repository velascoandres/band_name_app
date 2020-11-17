import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  Socket _socket;

  get serverStatus => this._serverStatus;

  Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = io('http://192.168.1.54:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    this._socket.on('connect', (data) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.on(
      'nuevo-mensaje',
      (data) {
        print(data);
        notifyListeners();
      },
    );
    this._socket.on(
      'disconnect',
      (_) {
        this._serverStatus = ServerStatus.Offline;
        notifyListeners();
      },
    );
  }
}
