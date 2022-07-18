import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:env_flutter/env_flutter.dart';

class SocketManager {
  late IO.Socket socket;
  bool isOnConnect = false;
  String username = "";
  late VoidCallback errorHandler;
  late VoidCallback onConnect;
  late Function onRecord;
  late VoidCallback onDisconnect;
  late VoidCallback onConnecting;

  SocketManager._privateConstructor();

  static final SocketManager _instance = SocketManager._privateConstructor();

  factory SocketManager() {
    return _instance;
  }

  tryConnect(String username, VoidCallback connectHandler, VoidCallback handler, Function recordHandler, VoidCallback disconnectHandler, VoidCallback connectingHandler) {
    SocketManager().username = username;
    SocketManager().onConnect = connectHandler;
    SocketManager().errorHandler = handler;
    SocketManager().onRecord = recordHandler;
    SocketManager().onDisconnect = disconnectHandler;
    SocketManager().onConnecting = connectingHandler;
    if (!isOnConnect) {
      setup();
    }
  }

  setup() {
    //var url = dotenv.env['SERVER_URL'];
    //print('url, $url');
    var url = 'https://satty.revocat.co';

    // socket = IO.io(url, <String, dynamic>{
    //   // 'secure': true,
    //   // 'reconnect': true,
    //   // 'rejectUnauthorized': false,
    //   'transports': ['websocket', 'polling', 'flashsocket'],
    //   'allowUpgrades': true,
    //   //'extraHeaders' : {'Access-Control-Allow-Origin': '*',
    //   // 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, DELETE'
    //   // }
    //   //'transports': ['websocket', 'polling']
    // });

    socket = IO.io(url, IO.OptionBuilder()
    .setPath('/connect/socket.io')
    .setTransports(['websocket', 'polling'])
    .build());
    // socket.opts[''];

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

    socket.onConnecting((data) {
      print(data);
      onConnecting();
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

  getLightStatus() {
    socket.emit('lightStatus', {});
  }
}
