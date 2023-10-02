import 'package:logging/src/logger.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../app/core/utils/get_storage_service.dart';

class SocketService {
  static final SocketService ins = SocketService._();

  SocketService._();

  static const _notiUrl = "https://mochi-api.azurewebsites.net/hubs/noti";
  late HubConnection _hubConnection;
  int _timeTryToConnection = 0;

  void initializeSocket() async {
    await _configHubConnection();
    await startHubConnection();
    _hubConnection.onclose(({error}) => _onCloseHandler(error));
  }

  Future<void> _configHubConnection() async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(_notiUrl,
            options: HttpConnectionOptions(
                accessTokenFactory: _getAccessToken,
                logger: Logger("SignalR - transport")))
        .configureLogging(Logger("SignalR - hub"))
        .build();
  }

  Future<void> startHubConnection() async {
    try {
      _timeTryToConnection++;
      if (_timeTryToConnection >= 100) {
        print("Socket try to connect more than 100 times. Disconnected");
        return;
      }
      await _hubConnection.start();
      print("SignalR connection success: ${_hubConnection.state}");
    } catch (e) {
      print("signalr connection error: $e");
      //if error then we try to connect again
      await startHubConnection();
    }
  }

  void disconnectHubConnection() {
  }

  void _onCloseHandler(Exception? error) {
    print("SignalRService error: $error");
    print("Connection closed");
    print("Restarting");
    startHubConnection();
  }

  Future<String> _getAccessToken() async {
    var token = GetStorageService.ins.getUserToken();
    return token!.substring(7);
  }

  void onListenMethod(
      {required String methodName, required Function(dynamic param) callBack}) {
    _hubConnection.on(methodName, callBack);
  }

  void invokeMethod({required String methodName, required Object args}) {
    try {
      _hubConnection.invoke(
        methodName,
        args: [args],
      );
    } catch (e) {
      print("Socket invoke method error: $e");
    }
  }
}
