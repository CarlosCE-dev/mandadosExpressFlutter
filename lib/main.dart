import 'package:flutter/material.dart';
// import 'package:mandados_express/src/services/auth_service.dart';
// import 'package:mandados_express/src/services/room_service.dart';

// Theme
// import 'package:mandados_express/src/theme/theme.dart';

// Router
// import 'package:mandados_express/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // final theme = new CustomTheme();
    
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider( create: (_) => AuthService() ),
        // ChangeNotifierProvider( create: (_) => RoomService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: theme.customTheme,
        title: 'Delivery App',
        initialRoute: 'loading',
        // routes: appRoutes,
      ),
    );
  }
}