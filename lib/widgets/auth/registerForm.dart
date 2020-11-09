part of 'widgets.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

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

              if ( registroOk ){

                // TODO: Mostar alerta con confirmacion

                Navigator.pushReplacementNamed(context, 'login');
              } else {
                showAlert( context, 'Registro incorrecto', "Revise la imformación rellada" );
              }
            },
          )
        ],
      ),
    );
  }
}