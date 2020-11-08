import 'package:flutter/material.dart';

// Lib
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

// Validators
import 'package:mandado_express_dev/validators/authValidators.dart';

// Helpers
import 'package:mandado_express_dev/helpers/ui/showAlert.dart';

// Widgets
import 'package:mandado_express_dev/widgets/auth/customButton.dart';
import 'package:mandado_express_dev/widgets/auth/customInput.dart';
import 'package:mandado_express_dev/widgets/auth/customLabel.dart';
import 'package:mandado_express_dev/widgets/general/smallLogo.dart';

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
                _Form(),
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

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passConfirmCtrl = TextEditingController();

  // Message error
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    
    return Container(
      margin: EdgeInsets.only( top: 5 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.account_circle,
            placeholder: 'Nombre(s)',
            keyboardType: TextInputType.text,
            textController: firstNameCtrl,
            fontColor: CustomColors.primary,
          ),
          CustomInput(
            icon: Icons.account_circle,
            placeholder: 'Apellido(s)',
            keyboardType: TextInputType.text,
            textController: lastNameCtrl,
            fontColor: CustomColors.primary,
          ),
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
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Confirmar contraseña',
            textController: passConfirmCtrl,
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
            text: 'Registrar',
            textColor: Colors.white,
            buttonColor: CustomColors.primary,
            onPress: authService.autenticando ? null : () async {
              final validate = validateRegister( firstNameCtrl.text, lastNameCtrl.text, emailCtrl.text, passCtrl.text, passConfirmCtrl.text );
              
              if ( !validate.state ) {
                setState(() {
                  errorMsg = validate.msg;
                });
                return;
              }
              errorMsg = "";

              FocusScope.of(context).unfocus();
              
              final registroOk = await authService.register(
                firstNameCtrl.text,
                lastNameCtrl.text,
                emailCtrl.text.trim(), 
                passCtrl.text.trim()
              );

              if ( registroOk == true ){
                // TODO: Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'login');
              } else {
                showAlert(
                  context, 
                  'Registro incorrecto', 
                  registroOk
                );
              }
            },
          )
        ],
      ),
    );
  }
}

