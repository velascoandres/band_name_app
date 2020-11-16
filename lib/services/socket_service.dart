import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    Socket socket = io('http://192.168.1.54:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    socket.on('connect', (data) => print('Connected'));
    socket.on(
      'mensaje',
      (data) {
        print(data);
      },
    );
    socket.on('disconnect', (_) => print('disconnect'));
  }
}
