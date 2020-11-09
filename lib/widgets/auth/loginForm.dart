part of 'widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false );
    final signalRService = Provider.of<SignalRService>(context, listen: false );

    emailCtrl.text = authService.user.email;
    passCtrl.text = authService.user.password;

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
                signalRService.connect();
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