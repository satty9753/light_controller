import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  bool isOnConnect = false;
  String username = "";

  static SocketManager shared () {
    return SocketManager();
  }

  tryConnect(String username) {
    SocketManager.shared().username = username;
    if (!isOnConnect) {
      SocketManager.shared().setup();
    }
  }

  setup() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket']
    });
    socket.onConnect((_) {
      print('on connect');
      isOnConnect = true;
      socket.on('joined', (data) {
        print('joined');
        //room, id
        print(data.runtimeType);
        print(data);
      });
    });

    socket.on('message', (data) {

    });

    socket.onConnectError((data) {
      isOnConnect = false;
      print(data);
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
}
