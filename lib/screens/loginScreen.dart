import 'package:flutter/material.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Widgets
import 'package:mandado_express_dev/widgets/auth/widgets.dart';
import 'package:mandado_express_dev/widgets/general/widgets.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: "Login",
                  color: CustomColors.primary
                ),
                LoginForm(),
                CustomLabel(
                  route: 'register',
                  primaryText: '¿No tienes cuenta?',
                  secodaryText: 'Crea una ahora!',
                  primaryTextColor: CustomColors.primary,
                ),
                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
   );
  }
}
