import 'package:flutter/material.dart';
import 'package:mandado_express_dev/services/signalRService.dart';

// Lib
import 'package:provider/provider.dart';

// Services
import 'package:mandado_express_dev/services/roomService.dart';
import 'package:mandado_express_dev/services/authService.dart';

// Theme
import 'package:mandado_express_dev/theme/theme.dart';

// Router
import 'package:mandado_express_dev/routes/routes.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final theme = new CustomTheme();
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => AuthService() ),
        ChangeNotifierProvider( create: (_) => RoomService() ),
        ChangeNotifierProvider( create: (_) => SignalRService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.customTheme,
        title: 'Delivery App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}