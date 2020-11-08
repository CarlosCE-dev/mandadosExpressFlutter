import 'package:flutter/material.dart';

// Screen
import 'package:mandado_express_dev/screens/chatScreen.dart';
import 'package:mandado_express_dev/screens/deliveryScreen.dart';
import 'package:mandado_express_dev/screens/homeScreen.dart';
import 'package:mandado_express_dev/screens/loadingScreen.dart';
import 'package:mandado_express_dev/screens/loginScreen.dart';
import 'package:mandado_express_dev/screens/registerScreen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'home': (_) => HomeScreen(),
  'loading': (_) => LoadingScreen(),
  'delivery' : (_) => DeliveryScreen(),
  'chat' : (_) => ChatScreen()
};