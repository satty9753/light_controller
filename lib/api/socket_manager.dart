import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  bool isOnConnect = false;
  String username = "";
  late VoidCallback errorHandler;
  late VoidCallback onConnect;
  late Function onRecord;
  late VoidCallback onDisconnect;

  SocketManager._privateConstructor();

  static final SocketManager _instance = SocketManager._privateConstructor();

  factory SocketManager() {
    return _instance;
  }

  tryConnect(String username, VoidCallback connectHandler, VoidCallback handler, Function recordHandler, VoidCallback disconnectHandler) {
    SocketManager().username = username;
    SocketManager().onConnect = connectHandler;
    SocketManager().errorHandler = handler;
    SocketManager().onRecord = recordHandler;
    SocketManager().onDisconnect = disconnectHandler;
    if (!isOnConnect) {
      setup();
    }
  }

  setup() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket', 'polling', 'flashsocket']
    });
    socket.onConnect((_) {
      print('on connect');
      isOnConnect = true;
      onConnect();
    });

    socket.on('record', (data) {
      var message = data['message'];
      var lightOn = data['lightOn'];
      onRecord(message, lightOn);
    });

    socket.onConnectError((data) {
      isOnConnect = false;
      print(data);
      errorHandler();
    });

    socket.onError((data) {
      print(data);
      errorHandler();
    });

    socket.onDisconnect((_) {
      isOnConnect = false;
      onDisconnect();
    }
    );
  }
  turnOnLight() {
    var data = {"username": username, "lightOn":true};
    socket.emit('light', data);
  }
  turnOffLight() {
    var data = {"username": username, "lightOn":false};
    socket.emit('light', data);
  }
}
