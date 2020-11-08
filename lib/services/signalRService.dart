import 'package:flutter/cupertino.dart';
import 'package:mandado_express_dev/global/environments.dart';

// Lib
import 'package:signalr_client/signalr_client.dart';
import 'package:logging/logging.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

// Models


class SignalRService with ChangeNotifier {

  HubConnection _signalR;

  void connect() async {

    // Configer the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    // If youn want to also to log out transport messages:
    final transportProtLogger = Logger("SignalR - transport");

    // Creates the connection by using the HubConnectionBuilder.
    this._signalR = HubConnectionBuilder().withUrl("${ Enviroments.socketUrl }/chatHub",
      options: HttpConnectionOptions(
        accessTokenFactory: () async => await getAccessToken(),
        logger: transportProtLogger,
      )
    ).build();

    await this._signalR.start().then( (_) {
        print("OnConnect");
    });
    
    this._signalR.onclose((_) {
      print("onClose");
    });
  }

  Future<String> getAccessToken() async {
    final token = await AuthService.getToken();
    return token;
  }
 

}