import 'package:flutter/cupertino.dart';
import 'package:mandado_express_dev/global/environments.dart';

// Lib
import 'package:signalr_client/signalr_client.dart';
import 'package:logging/logging.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

class SignalRService with ChangeNotifier {

  HubConnection _signalR;

  HubConnection get signalRConnection => this._signalR;

  void connect() async {

    final token = await AuthService.getToken();

    // Configer the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    final hubProtLogger = Logger("SignalR - hub");

    // If youn want to also to log out transport messages:
    final transportProtLogger = Logger("SignalR - transport");

    // Creates the connection by using the HubConnectionBuilder.
    this._signalR = HubConnectionBuilder().withUrl("${ Enviroments.socketUrl }/chatHub?token=$token",
      options: HttpConnectionOptions(
        logger: transportProtLogger,
      )
    ).configureLogging(hubProtLogger).build();

    await this._signalR.start().then( (_) {
        print("OnConnect");
    });
    
    this._signalR.onclose((_) {
      print("onClose");
    });
  }

  void disconnect(){
    // TODO: Desconectar
  }
 

}