import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  bool isOnConnect = false;
  String username = "";
  late VoidCallback errorHandler;
  late VoidCallback onConnect;
  
  static SocketManager shared () {
    return SocketManager();
  }

  tryConnect(String username, VoidCallback connectHandler, VoidCallback handler) {
    username = username;
    onConnect = connectHandler;
    errorHandler = handler;
    if (!isOnConnect) {
      setup();
    }
  }

  setup() {
    socket = IO.io('http://10.102.251.51:80', <String, dynamic>{
      'transports': ['websocket', 'polling', 'flashsocket']
    });
    socket.onConnect((_) {
      print('on connect');
      isOnConnect = true;
      onConnect();
    });

    socket.on('record', (data) {
      
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

  sendRecord() {
    
  }
}
