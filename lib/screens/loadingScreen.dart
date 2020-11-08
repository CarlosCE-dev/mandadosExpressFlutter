import 'package:flutter/material.dart';

// Lib
import 'package:flare_flutter/flare_actor.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

// Screens
import 'package:mandado_express_dev/screens/homeScreen.dart';
import 'package:mandado_express_dev/screens/loginScreen.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF1C1E1D),
      body: Container(
        height: size.height,
        width: size.width,
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                FlareActor(
                  "assets/animation/SplashScreen.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  animation: "go",
                ),
                Positioned(
                  bottom: 40,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Text('Cargando...', style: TextStyle(fontFamily: 'JosefinSans', color: Colors.white, fontSize: 25 ),),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false );
    
    await Future.delayed(Duration( seconds: 3 ) );

    final autenticado = await authService.isLoggedIn();

    if ( autenticado ){
      // TODO: Conectar al socket server
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionDuration: Duration( milliseconds: 3000 ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeIn(
              child: child,
            );
          },
        )
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
          transitionDuration: Duration( milliseconds: 3000 ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeIn(
              child: child,
            );
          },
        )
      );
    } 
  }
}