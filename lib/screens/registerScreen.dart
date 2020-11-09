import 'package:flutter/material.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Widgets
import 'package:mandado_express_dev/widgets/auth/widgets.dart';
import 'package:mandado_express_dev/widgets/general/widgets.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height *.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SmLogo(
                  color: CustomColors.primary,
                  titulo: 'Registro',
                ),
                RegisterForm(),
                CustomLabel(
                  route: 'login',
                  primaryText: '¿Ya tienes cuenta?',
                  secodaryText: 'Ingresa con tu cuenta!',
                  primaryTextColor: CustomColors.primary,
                ),
                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w400 ),)
              ],
            ),
          ),
        ),
      )
   );
  }
}



