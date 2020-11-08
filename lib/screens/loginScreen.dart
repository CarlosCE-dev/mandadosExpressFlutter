import 'package:flutter/material.dart';

// Lib
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Helpers
import 'package:mandado_express_dev/helpers/ui/showAlert.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

// Validators
import 'package:mandado_express_dev/validators/authValidators.dart';

// Widgets
import 'package:mandado_express_dev/widgets/auth/customButton.dart';
import 'package:mandado_express_dev/widgets/auth/customInput.dart';
import 'package:mandado_express_dev/widgets/auth/customLabel.dart';
import 'package:mandado_express_dev/widgets/general/logo.dart';

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
                _Form(),
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

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false );

    emailCtrl.text = authService.user.email;
    passCtrl.text = authService.user.password;

    emailCtrl.text = "customer@customer.com";
    passCtrl.text = "Tenco1234\$";

    return Container(
      margin: EdgeInsets.only( top:40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            fontColor: CustomColors.primary,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
            fontColor: CustomColors.primary,
          ),
          ( errorMsg.isEmpty )
          ? SizedBox()
          : ElasticIn(
            duration: Duration( milliseconds: 300 ),
            child: Container(
              padding: EdgeInsets.symmetric( vertical: 10 ),
              child: Wrap(
                children: <Widget>[
                    Text( errorMsg, style: TextStyle( color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.w500 )),
                ]
              )
            ),
          ),
          CustomButton(
            buttonColor: CustomColors.primaryLight,
            text: 'Ingresar',
            textColor: Colors.white,
            onPress: authService.autenticando ? null : () async {
              final validate = validateLogin( emailCtrl.text, passCtrl.text );
              if ( !validate.state ) {
                setState(() {
                  errorMsg = validate.msg;
                });
                return;
              }
              errorMsg = "";

              FocusScope.of(context).unfocus();
              
              final response = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              if ( response ){
                // TODO: Conectar a nuestro socket server
                // TODO: Navegar a otra pantala
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                showAlert(context, 'Login incorrecto', 'Revise sus credenciales nuevamante');
              }
            },
          )
        ],
      ),
    );
  }
}